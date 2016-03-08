with
source as (
  -- Filter records by time or value here. Change the source view for your analysis
  select * from analyst_collective.snowplow_events
  where "@timestamp" > getdate() - interval '1 week'
),
step_1 as (
  -- filter by whichever columns you need
  select * from source where "@event" = 'page_view' 
),
  -- add more steps as you need. if you do add more steps, make sure to add a join below
step_2 as (
  select * from source where "@event" = 'page_ping'
),
step_3 as (
  select * from source where "@event" = 'link_click'
),
funnel as (
  -- add or remove joins and selects here! You need one count(distinct step_x."@user_id") and one join for each step
  select count(distinct step_1."@user_id") as "step_1_users",
         count(distinct step_2."@user_id") as "step_2_users",
         count(distinct step_3."@user_id") as "step_3_users"
    from step_1
    left outer join step_2 on step_1."@user_id" = step_2."@user_id" and step_1."@timestamp" < step_2."@timestamp"
    left outer join step_3 on step_2."@user_id" = step_3."@user_id" and step_2."@timestamp" < step_3."@timestamp"
),
pivot as (
  select 1 as stage, step_1_users as count from funnel union all
  select 2, step_2_users from funnel union all
  select 3, step_3_users from funnel
),
presentation as (
  select 
  stage, count,
  count::float / (lag(count) over (order by stage))::float as pct_of_previous
  from pivot
  order by stage
)
select * from presentation
