
SELECT
  date_trunc('day', "@timestamp"), -- use second, minute, hour, day, week, month, quarter, etc
  count(*)
from analyst_collective.snowplow_events
where "@timestamp" > getdate() - interval '1 week'
  --and "@event" = 'signup' -- filter fields here
group by 1 order by 1 desc
