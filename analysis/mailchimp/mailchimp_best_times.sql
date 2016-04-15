with email_summary as (

  select *
  from {{env.schema}}.mailchimp_email_summary

), best_day_of_week as (

  select date_part(dow, sent_date), avg(opened::float)
  from email_summary
  group by 1
  order by 1

), best_hour_of_day as (

  select date_part(hr, sent_date), avg(opened::float)
  from email_summary
  group by 1
  order by 1

)

select *
from best_day_of_week
