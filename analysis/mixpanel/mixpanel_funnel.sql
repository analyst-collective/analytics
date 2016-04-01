with
source as (
    select * from {{env.schema}}.mixpanel_export -- change this view for your analysis
),

step_1 as (
    select min(event_date) as event_date, user_id
    from source
        where event = 'event_1' -- filter by whichever columns you need
    group by user_id
),

-- add more steps as you need. If you do add more steps, make sure to add a join below
step_2 as (
    select min(event_date) as event_date, user_id
    from source
        where event = 'event_2'
    group by user_id
),

step_3 as (
    select min(event_date) as event_date, user_id
    from source
        where event = 'event_3'
    group by user_id
),

step_4 as (
    select min(event_date) as event_date, user_id
    from source
        where event = 'event_4'
    group by user_id
),

step_5 as (
    select min(event_date) as event_date, user_id
    from source
        where event = 'event_5'
    group by user_id
),

temp_funnel as (

    select 1 as funnel_idx, 'step_1' as funnel_step, count(distinct user_id) as num_current_step
    from step_1
    union
    select 2 as funnel_idx, 'step_2' as funnel_step, count(distinct user_id) as num_current_step
    from step_2
    union
    select 3 as funnel_idx, 'step_3' as funnel_step, count(distinct user_id) as num_current_step
    from step_3
    union
    select 4 as funnel_idx, 'step_4' as funnel_step, count(distinct user_id) as num_current_step
    from step_4
    union
    select 5 as funnel_idx, 'step_5' as funnel_step, count(distinct user_id) as num_current_step
    from step_5
)


select
    funnel_step, num_current_step as funnel_count,
    round(100.0*num_current_step/num_previous_step, 2) as pcnt_previous,
    round(100.0*num_current_step/num_first_step, 2) as pcnt_overall
from
(
    select
        funnel_idx, funnel_step, num_current_step,
        -- lag the funnel numbers to compute conversion ratios
        lag(num_current_step) over(order by funnel_idx) as num_previous_step,
        -- get the first step number to compute the overall conversion ratio
        max(num_current_step) over() as num_first_step
    from temp_funnel
)
order by funnel_idx
