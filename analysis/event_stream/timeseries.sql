
SELECT
  date_trunc('day', "@timestamp"),
  count(*)
from analyst_collective.snowplow_events
where "@timestamp" > getdate() - interval '1 week'
group by 1 order by 1 desc

