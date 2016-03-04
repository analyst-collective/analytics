with
source as (
  select * from analyst_collective.snowplow_events -- change this view for your analysis
),
steps as (
  select 1 as stage, 'page_view' as "@event" union all
  select 2, 'page_ping' union all
  select 3, 'link_click'
),
people_events as (
  select stage, "@user_id", "@event", min("@timestamp") as "@timestamp" from (
    select steps.stage, source."@user_id", source."@event", source."@timestamp"
    from source
    join steps on source."@event" =  steps."@event"
    where "@timestamp" > getdate() - interval '1 week'
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
presentation as (
  select stage, "@event", count,
  count::float / (lag(count) over (order by stage))::float as pct_of_previous
  from funnel
  order by stage
)

select * from presentation
