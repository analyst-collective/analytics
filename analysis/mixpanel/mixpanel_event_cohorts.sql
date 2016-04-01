with
mixpanel_events as
(
    select *
    from {{env.schema}}.mixpanel_export
),

first_event_data as
(
    -- find all (user, date) records for the first event of interest
    select
        user_id, first_event_date
    from
    (
        -- pick the first occurence of the event of interest fo cohorting purposes
        select user_id, min(event_date) as first_event_date
        from mixpanel_events
        where
            -- specifiy the first event of interest
            event = 'event_1'
        group by user_id
    )
),

second_event_data as (
    -- find all (user, date) records for the second event of interest
    select user_id, event_date as second_event_date
    from mixpanel_events
    where
        -- specify the second event of interest
        event = 'visualize impactful channels'
),

combined_event_data as
(
    -- get the table of first and second event dates for each user
    select first_event_data.user_id, first_event_date, second_event_date
    from first_event_data
    inner join second_event_data
        on first_event_data.user_id = second_event_data.user_id
),

cohort_sizes as
(
    -- compute cohort sizes
    select
        date_trunc('week', first_event_date)::date as cohort_date,
        count(distinct user_id) as cohort_size
    from combined_event_data
    group by date_trunc('week', first_event_date)
),

cohort_data as (
    select cohorts.cohort_date, cohort_size, user_id, days_to_second_event
    from
    (
        select
            user_id, date_trunc('week', first_event_date)::date as cohort_date,
            datediff(day, first_event_date, second_event_date) as days_to_second_event
        from combined_event_data
    ) cohorts
    inner join cohort_sizes
    on cohorts.cohort_date = cohort_sizes.cohort_date
)

select
    cohort_date, cohort_size, days_to_second_event, count(distinct user_id) as users,
    count(distinct user_id)::float/cohort_size as portion_of_users
from cohort_data
group by cohort_date, cohort_size, days_to_second_event
order by cohort_date, cohort_size, days_to_second_event



