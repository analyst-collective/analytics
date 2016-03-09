WITH
source as (
  select * from analyst_collective.snowplow_events -- change this view for your analysis
),
step_1 as (
  SELECT MIN("@timestamp") as "@timestamp", "@user_id"
  FROM source
    WHERE "@event" = 'page_view' -- filter by whichever columns you need
  GROUP BY "@user_id"
),
-- add more steps as you need. If you do add more steps, make sure to add a join below
step_2 as (
  SELECT MIN("@timestamp") as "@timestamp", "@user_id"
  FROM source
    WHERE "@event" = 'page_ping'
  GROUP BY "@user_id"
),
step_3 as (
  SELECT MIN("@timestamp") as "@timestamp", "@user_id"
  FROM source
    WHERE "@event" = 'link_click'
  GROUP BY "@user_id"
),
funnel as (
  --where the magic happens!
  SELECT step_1."@user_id" as "step_1_users",
         step_2."@user_id" as "step_2_users",
         step_3."@user_id" as "step_3_users"
    from step_1
    -- add more joins to make funnels with more steps
    LEFT OUTER JOIN step_2 ON step_1."@user_id" = step_2."@user_id" and step_1."@timestamp" < step_2."@timestamp"
    LEFT OUTER JOIN step_3 ON step_2."@user_id" = step_3."@user_id" and step_2."@timestamp" < step_3."@timestamp"
  -- filter by time here
  where step_1."@timestamp" > getdate() - interval '1 week'
)

select
count(distinct step_1_users) as step_1,
count(distinct step_2_users) as step_2,
count(distinct step_3_users) as step_3

from funnel
