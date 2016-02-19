--status: not yet incorporated

-- originally sourced from URL:
-- https://medium.com/swlh/diligence-at-social-capital-epilogue-introducing-the-8-ball-and-gaap-for-startups-7ab215c378bc

with
    dau as (
        -- This part of the query can be pretty much anything.
        -- The only requirement is that it have three columns:
        --   dt, user_id, inc_amt
        -- Where dt is a date and user_id is some unique identifier for a user.
        -- Each dt-user_id pair should be unique in this table.
        -- inc_amt represents the amount of value that this user created on dt.
        -- The most common case is
        --   inc_amt = incremental revenue from the user on dt
        -- If you want to do L28 growth accounting, user inc_amt=1.
        -- The version here derives everything from the tutorial.yammer_events
        -- data set provided for free by Mode.
        -- If you edit just this part to represent your data, the rest
        -- of the query should run just fine.
        -- The query here is a sample that works in the public Mode Analytics
        -- tutorial.
        select
            user_id,
            date(occurred_at) as dt,
            sum(user_type) as inc_amt
        from tutorial.yammer_events
        group by 1,2
    ),
    -- First, set up WAU and MAU tables for future use
    wau as (
        select
            date_trunc('week', dt) as week,
            user_id,
            sum(inc_amt) as inc_amt
        from dau
        group by 1,2
    ),
    mau as (
        select
            date_trunc('month',dt) as month,
            user_id,
            sum(inc_amt) as inc_amt
        from dau
        group by 1,2
    ),
    -- This determines the cohort date of each user. In this case we are
    -- deriving it from DAU data but you can feel free to replace it with
    -- registration date if that's more appropriate.
    first_dt as (
        select
            user_id,
            min(dt) as first_dt,
            date_trunc('week', min(dt)) as first_week,
            date_trunc('month', min(dt)) as first_month
        from dau
        group by 1
    ),
    mau_decorated as (
        select
            d.month,
            d.user_id,
            d.inc_amt,
            f.first_month
        from mau d, first_dt f
        where d.user_id = f.user_id
        and inc_amt > 0
    ),
    -- This is MAU growth accounting. Note that this does not require any
    -- information about inc_amt. As discussed in the articles, these
    -- quantities satisfy some identities:
    -- MAU(t) = retained(t) + new(t) + resurrected(t)
    -- MAU(t - 1 month) = retained(t) + churned(t)
    mau_growth_accounting as (
        select
            coalesce(tm.month, lm.month + interval '1 month') as month,
            count(distinct tm.user_id) as mau,
            count(distinct case when lm.user_id is not NULL then tm.user_id
                else NULL end) as retained,
            count(distinct case when tm.first_month = tm.month then tm.user_id
                else NULL end) as new,
            count(distinct case when tm.first_month != tm.month
                and lm.user_id is NULL then tm.user_id else NULL end
                ) as resurrected,
            -1*count(distinct case when tm.user_id is NULL then lm.user_id
                else NULL end) as churned
        from
            mau_decorated tm
            full outer join mau_decorated lm on (
                tm.user_id = lm.user_id
                and tm.month = lm.month + interval '1 month'
            )
        group by 1
    ),
    -- This generates the familiar monthly cohort retention dataset.
    mau_retention_by_cohort as (
        select
            first_month,
            12 * extract(year from age(month, first_month)) +
                extract(month from age(month, first_month)) as months_since_first,
            count(1) as active_users,
            sum(inc_amt) as inc_amt
        from mau_decorated
        group by 1,2
        order by 1,2
    ),
    -- This is the MRR growth accounting (or growth accounting of whatever
    -- value you put in inc_amt). These also satisfy some identities:
    -- MRR(t) = retained(t) + new(t) + resurrected(t) + expansion(t)
    -- MAU(t - 1 month) = retained(t) + churned(t) + contraction(t)
    mrr_growth_accounting as (
        select
            coalesce(tm.month, lm.month + interval '1 month') as month,
            sum(tm.inc_amt) as rev,
            sum(
                case
                    when tm.user_id is not NULL and lm.user_id is not NULL
                        and tm.inc_amt >= lm.inc_amt then lm.inc_amt
                    when tm.user_id is not NULL and lm.user_id is not NULL
                        and tm.inc_amt < lm.inc_amt then tm.inc_amt
                    else 0
                end
            ) as retained,
            sum(
                case when tm.first_month = tm.month then tm.inc_amt
                else 0 end
            ) as new,
            sum(
                case when tm.month != tm.first_month and tm.user_id is not NULL
                    and lm.user_id is not NULL and tm.inc_amt > lm.inc_amt
                    and lm.inc_amt > 0 then tm.inc_amt - lm.inc_amt
                else 0 end
            ) as expansion,
            sum(
                case when tm.user_id is not NULL
                    and (lm.user_id is NULL or lm.inc_amt = 0)
                    and tm.inc_amt > 0 and tm.first_month != tm.month
                    then tm.inc_amt
                else 0 end
            ) as resurrected,
            -1 * sum(
                case
                    when tm.month != tm.first_month and tm.user_id is not NULL
                        and lm.user_id is not NULL
                        and tm.inc_amt < lm.inc_amt and tm.inc_amt > 0
                        then lm.inc_amt - tm.inc_amt
                else 0 end
            ) as contraction,
            -1 * sum(
                case when lm.inc_amt > 0 and (tm.user_id is NULL or tm.inc_amt = 0)
                then lm.inc_amt else 0 end
            ) as churned
        from
            mau_decorated tm
            full outer join mau_decorated lm on (
                tm.user_id = lm.user_id
                and tm.month = lm.month + interval '1 month'
            )
        group by 1
    ),
    -- These next tables are to compute LTV via the cohorts_cumulative table.
    -- The LTV here is being computed for weekly cohorts on weekly intervals.
    -- The queries can be modified to compute it for cohorts of any size
    -- on any time window frequency.
    wau_decorated as (
        select
            week,
            w.user_id,
            w.inc_amt,
            f.first_week
        from wau w, first_dt f
        where w.user_id = f.user_id
    ),
    cohorts as (
        select
            first_week,
            week as active_week,
            ceil(extract(DAYS from (week - first_week))/7.0) as weeks_since_first,
            count(distinct user_id) as users,
            sum(inc_amt) as inc_amt
        from wau_decorated
        group by 1,2,3
        order by 1,2
    ),
    cohort_sizes as (
        select
            first_week,
            users,
            inc_amt
        from cohorts
        where weeks_since_first = 0
    ),
    cohorts_cumulative as (
        -- A semi-cartesian join accomplishes the cumulative behavior.
        select
            c1.first_week,
            c1.active_week,
            c1.weeks_since_first,
            c1.users,
            cs.users as cohort_num_users,
            1.0 * c1.users/cs.users as retained_pctg,
            c1.inc_amt,
            sum(c2.inc_amt) as cum_amt,
            sum(c2.inc_amt)/cs.users as cum_amt_per_user
        from
            cohorts c1,
            cohorts c2,
            cohort_sizes cs
        where
            c1.first_week = c2.first_week
            and c2.weeks_since_first <= c1.weeks_since_first
            and cs.first_week = c1.first_week
        group by 1,2,3,4,5,6,7
        order by 1,2
    )

-- For MAU retention by cohort, useful for the standard retention heatmap
select * from mau_retention_by_cohort

-- For cumulative LTV data use this
select * from cohorts_cumulative

-- For MAU growth accuonting use this
select * from mau_growth_accounting

-- For MRR growth accuonting use this
select * from mrr_growth_accounting

-- For use as input in the 8-ball tool use this
select
    first_week as cohort_week,
    active_week as activity_week,
    users,
    inc_amt as revenue
from cohorts_cumulative
