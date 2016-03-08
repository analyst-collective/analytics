with
source as (
  -- edit this subquery to point to the desired table and filter events by time/value
  select * from analyst_collective.snowplow_events 
    where "@timestamp" > getdate() - interval '1 week'
),
steps as (
  -- add or remove steps here. Make sure to keep track of the stage number and add "union all" to each line
  select 1 as stage, 'page_view' as "@event" union all
  select 2, 'page_ping' union all
  select 3, 'link_click'
),
people_events as (
  select stage, "@user_id", "@event", min("@timestamp") as "@timestamp" from (
    select steps.stage, source."@user_id", source."@event", source."@timestamp"
    from source
    join steps on source."@event" =  steps."@event"
  )
  group by 1, 2, 3
),
filtered as (
  select stage, "@user_id", "@event", "@timestamp" from (
    select stage, "@user_id", "@event", "@timestamp",
    lag("@timestamp", 1) over (partition by "@user_id" order by "@user_id", "stage") as prev_event_timestamp
    from people_events
  )
  where prev_event_timestamp is null or "@timestamp" > prev_event_timestamp
),
funnel as (
  select stage, "@event", count(*) as count from filtered group by 1, 2
),
full_funnel as (
  select steps.stage, steps."@event", coalesce(funnel.count, 0) as count from steps
    left outer join funnel on funnel.stage = steps.stage
),
presentation as (
  select stage, "@event", count,
  case when (lag(count) over (order by stage)) = 0 then
    0
  else
    (count::float / (lag(count) over (order by stage)))
  end as pct_of_previous
  from full_funnel
  order by stage
)
select * from presentation
