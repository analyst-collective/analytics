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
