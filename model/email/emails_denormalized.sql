with events as (

  select * from {{env.schema}}.emails

),

sends as (

  select "@user_id", "@timestamp", "@email_id"
  from events
  where "@event" = 'email sent'

),

opens as (

  select "@user_id", "@timestamp", "@email_id"
  from events
  where "@event" = 'email opened'

), clicks as (

  select "@user_id", "@timestamp", "@email_id"
  from events
  where "@event" = 'email click'

)

select s."@user_id", s."@timestamp" as sent_timestamp, o."@timestamp" as opened_timestamp, c."@timestamp" as clicked_timestamp,
  decode(o."@timestamp", null, 0, 1) as "opened?",
  decode(c."@timestamp", null, 0, 1) as "clicked?",
  row_number() over (partition by s."@user_id" order by s."@timestamp") as email_number
from sends s
  left outer join opens o on s."@email_id" = o."@email_id"
  left outer join clicks c on s."@email_id" = c."@email_id"
order by 1, 2
