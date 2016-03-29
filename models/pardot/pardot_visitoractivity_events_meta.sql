--even with the type decoding that Pardot specifically provides, actually what is going on in a given event
--is somewhat ambiguous. this is an attempt to map type and type_name to a more event-based "event action" field
--which is always written in more standard action-oriented terms.
select 22 as "type", 'Chat Transcript' as type_name, 'chatted via olark' as event_name union all
select 21, 'Custom Redirect', 'clicked a custom redirect' union all
select 6, 'Email', 'email sent' union all
select 11, 'Email', 'email opened' union all
select 13, 'Email', 'email bounced' union all
select 14, 'Email', 'email reported spam' union all
select 1, 'Email Tracker', 'email click' union all
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
