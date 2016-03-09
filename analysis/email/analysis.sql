/*

This analysis gets you a simple timeseries of sent > opened > clicked emails for all-time.

*/


with events as (

  select * from analyst_collective.emails_denormalized

)

select
  date_trunc('month', "sent_timestamp") as mnth,
  count(*) as sends,
  sum("opened?") as opens,
  sum("clicked?") as clicks,
  avg("opened?"::float) as open_rate,
  avg("clicked?"::float) as click_rate
from events
group by 1
order by 1
;



/*

Open/click rate by user's email number. Email number 1 is the first email sent to that user, etc.
Do people stop engaging with emails the more emails they have been sent?

*/


with emails as (

  select * from analyst_collective.emails_denormalized

)

select email_number, avg("opened?"::float) as open_rate, avg("clicked?"::float) as ctr,
  count(*) as num_users
from emails
--only look at the first 25 emails someone is sent. should be customized based on business.
where email_number < 26
group by 1
order by 1
;




/*

Open/Click rate by email frequency.
Does email sending volume have an impact on engagement with emails sent?
In the extended email interface, need to do the same thing for unsubscribes, because this is where we have seen the strong correlation in the past.
This interface doesn't contain unsubscribe data.

*/


with emails as (

  select * from analyst_collective.emails_denormalized

)

select date_trunc('month', sent_timestamp),
  count(*)::float / count(distinct "@user_id")::float as emails_per_user,
  avg("opened?"::float) as open_rate, avg("clicked?"::float) as ctr
from emails
group by 1
order by 1
;




/*

Other analysis I still want to do:
 - cohort analysis of email engagement vs first email send date.
 - anomaly detection for email performance: particularly good or bad email subject lines by open rate. leave out bottom 20% of send volume.
 - likelihood of opening / clicking by length (time or # of emails) of user inactivity

*/
