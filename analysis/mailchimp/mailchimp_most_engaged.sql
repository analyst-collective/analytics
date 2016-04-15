with email_summary as (

  select *
  from {{env.schema}}.mailchimp_email_summary

)

select email_id, sum(clicked)::float / sum(opened)
from email_summary
group by 1
having sum(opened) > 5
order by 2 desc
limit 100
