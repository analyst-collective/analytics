with
source as (
  select * from analyst_collective.snowplow_events -- change this view for your analysis
),
filtered as (
  select * from source
    where "@timestamp" > getdate() - interval '1 week'
    --and "@event" = 'signup' -- filter fields here
)
select
  date_trunc('day', "@timestamp"), -- use second, minute, hour, day, week, month, quarter, etc
  count(*)
from source
group by 1 order by 1 desc
