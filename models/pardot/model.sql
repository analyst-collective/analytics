create or replace view {schema}.visitoractivity_types_meta as (

  --these literal values are pulled from pardot's api docs here:
  --http://developer.pardot.com/kb/object-field-references/#visitor-activity
  --they change periodically over time and this query will need to be correspondingly modified.
  select 1 as type, 'Click' as type_decoded union all
  select 2, 'View' union all
  select 3, 'Error' union all
  select 4, 'Success' union all
  select 5, 'Session' union all
  select 6, 'Sent' union all
  select 7, 'Search' union all
  select 8, 'New Opportunity' union all
  select 9, 'Opportunity Won' union all
  select 10, 'Opportunity Lost' union all
  select 11, 'Open' union all
  select 12, 'Unsubscribe Page' union all
  select 13, 'Bounced' union all
  select 14, 'Spam Complaint' union all
  select 15, 'Email Preference Page' union all
  select 16, 'Resubscribed' union all
  select 17, 'Click (Third Party)' union all
  select 18, 'Opportunity Reopened' union all
  select 19, 'Opportunity Linked' union all
  select 20, 'Visit' union all
  select 21, 'Custom URL click' union all
  select 22, 'Olark Chat' union all
  select 23, 'Invited to Webinar' union all
  select 24, 'Attended Webinar' union all
  select 25, 'Registered for Webinar' union all
  select 26, 'Social Post Click' union all
  select 27, 'Video View' union all
  select 28, 'Event Registered' union all
  select 29, 'Event Checked In' union all
  select 30, 'Video Conversion' union all
  select 31, 'UserVoice Suggestion' union all
  select 32, 'UserVoice Comment' union all
  select 33, 'UserVoice Ticket' union all
  select 34, 'Video Watched (>= 75% watched)'

);



create or replace view {schema}.visitoractivity_events_meta as (

  --even with the type decoding that Pardot specifically provides, actually what is going on in a given event
  --is somewhat ambiguous. this is an attempt to map type and type_name to a more event-based "event action" field
  --which is always written in more standard action-oriented terms. 
  select 22 as "type", 'Chat Transcript' as type_name, 'chatted via olark' as event_name union all
  select 21, 'Custom Redirect', 'clicked a custom redirect' union all
  select 6, 'Email', 'sent an email' union all
  select 11, 'Email', 'opened an email' union all
  select 13, 'Email', 'bounced email' union all
  select 14, 'Email', 'reported spam' union all
  select 1, 'Email Tracker', 'clicked on email link' union all
  select 28, 'Event', 'registered for event' union all
  select 29, 'Event', 'checked in at event' union all
  select 2, 'File', 'viewed a file' union all
  select 3, 'Form', 'submitted a form with an error' union all
  select 2, 'Form', 'viewed a form' union all
  select 4, 'Form', 'successfully submitted a form' union all
  select 4, 'Form Handler', 'successfully submitted a form handler' union all
  select 2, 'Landing Page', 'viewed a landing page' union all
  select 4, 'Landing Page', 'successfully submitted the form on a landing page' union all
  select 3, 'Landing Page', 'submitted the form on a landing page with an error' union all
  select 2, 'Multivariate Landing Page', 'viewed multivariate landing page' union all
  select 4, 'Multivariate Landing Page', 'successfully submitted multivariate landing page' union all
  select 3, 'Multivariate Landing Page', 'submitted multivariate landing page with an error' union all
  select 8, 'New Opportunity', 'opened opportunity' union all
  select 19, 'Opportunity Associated', 'linked existing opportunity' union all
  select 10, 'Opportunity Lost', 'lost opportunity' union all
  select 9, 'Opportunity Won', 'won opportunity' union all
  select 2, 'Page View', 'viewed highlighted page' union all
  select 34, 'Video', 'watched 75% or more of video' union all
  select 27, 'Video', 'watched video' union all
  select 30, 'Video', 'converted from video call to action' union all
  select 20, 'Visit', 'visited website' union all
  select 25, 'Webinar', 'registered for webinar' union all
  select 24, 'Webinar', 'attended webinar' union all
  select 18, '', 'reopened opportunity'

);


create or replace view {schema}.visitoractivity as (
  --this table has a bunch of types that really should be event actions but are very poorly formulated.
  --the custom logic in this view is an attempt to fix that.
  --not all of the various type / type_name combinations have been accounted for yet; I still need to determine exactly what some of them mean.
  select
    -- event_stream interface
    va.created_at       as "@timestamp",
    t.type_decoded      as "@event",
    va.prospect_id      as "@user_id",
    va.*
  from
    olga_pardot.visitoractivity va
    inner join {schema}.visitoractivity_events_meta e
      on va."type" = e."type" and va.type_name = e.type_name
    inner join {schema}.visitoractivity_types_meta t
      on va."type" = t."type"
);

comment on view {schema}.visitoractivity is 'timeseries,funnel,cohort';
