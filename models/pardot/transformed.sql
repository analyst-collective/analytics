create or replace view pardot.visitor_activity_transformed as (
	--this table has a bunch of types that really should be event actions but are very poorly formulated.
	--the custom logic in this view is an attempt to fix that.
	--not all of the various type / type_name combinations have been accounted for yet; I still need to determine exactly what some of them mean.
	select
		campaign_id									as campaign_id,
		form_handler_id							as form_handler_id,
		id													as id,
		email_id										as email_id,
		type_name										as type_name,
		"type"											as "type",
		details											as details,
		created_at									as created_at,
		prospect_id									as prospect_id,
		visitor_id									as visitor_id,
		opportunity_id							as opportunity_id,
		case
			--these literal values are pulled from pardot's api docs here:
			--http://developer.pardot.com/kb/object-field-references/#visitor-activity
			--they change periodically over time and this query will need to be correspondingly modified.
	    when type = 1 then 'Click'
	    when type = 2 then 'View'
	    when type = 3 then 'Error'
	    when type = 4 then 'Success'
	    when type = 5 then 'Session'
	    when type = 6 then 'Sent'
	    when type = 7 then 'Search'
	    when type = 8 then 'New Opportunity'
	    when type = 9 then 'Opportunity Won'
	    when type = 10 then 'Opportunity Lost'
	    when type = 11 then 'Open'
	    when type = 12 then 'Unsubscribe Page'
	    when type = 13 then 'Bounced'
	    when type = 14 then 'Spam Complaint'
	    when type = 15 then 'Email Preference Page'
	    when type = 16 then 'Resubscribed'
	    when type = 17 then 'Click (Third Party)'
	    when type = 18 then 'Opportunity Reopened'
	    when type = 19 then 'Opportunity Linked'
	    when type = 20 then 'Visit'
	    when type = 21 then 'Custom URL click'
	    when type = 22 then 'Olark Chat'
	    when type = 23 then 'Invited to Webinar'
	    when type = 24 then 'Attended Webinar'
	    when type = 25 then 'Registered for Webinar'
	    when type = 26 then 'Social Post Click'
	    when type = 27 then 'Video View'
	    when type = 28 then 'Event Registered'
	    when type = 29 then 'Event Checked In'
	    when type = 30 then 'Video Conversion'
	    when type = 31 then 'UserVoice Suggestion'
	    when type = 32 then 'UserVoice Comment'
	    when type = 33 then 'UserVoice Ticket'
	    when type = 34 then 'Video Watched (≥ 75% watched)'
	  end as type_decoded,
	  case
	    when type = 22 and type_name = 'Chat Transcript' then 'chatted via olark'
	    when type = 21 and type_name = 'Custom Redirect' then 'clicked a custom redirect'
	    when type = 6 and type_name = 'Email' then 'sent email'
	    when type = 11 and type_name = 'Email' then 'opened email'
	    when type = 13 and type_name = 'Email' then 'bounced email'
	    when type = 14 and type_name = 'Email' then 'reported spam'
	    when type = 1 and type_name = 'Email Tracker' then 'clicked on email link'
	    when type = 28 and type_name = 'Event' then 'registered for event'
	    when type = 29 and type_name = 'Event' then 'checked in at event'
	    when type = 2 and type_name = 'File' then 'viewed file'
	    when type = 3 and type_name = 'Form' then 'submitted form with an error'
	    when type = 2 and type_name = 'Form' then 'viewed form'
	    when type = 4 and type_name = 'Form' then 'successfully submitted form'
	    when type = 4 and type_name = 'Form Handler' then 'successfully submitted form handler'
	    when type = 2 and type_name = 'Landing Page' then 'viewed landing page'
	    when type = 4 and type_name = 'Landing Page' then 'successfully submitted the form on a landing page'
	    when type = 3 and type_name = 'Landing Page' then 'submitted the form on a landing page with an error'
	    when type = 2 and type_name = 'Multivariate Landing Page' then 'viewed multivariate landing page'
	    when type = 4 and type_name = 'Multivariate Landing Page' then 'successfully submitted multivariate landing page'
	    when type = 3 and type_name = 'Multivariate Landing Page' then 'submitted multivariate landing page with an error'
	    when type = 8 and type_name = 'New Opportunity' then 'opened opportunity'
	    when type = 19 and type_name = 'Opportunity Associated' then 'linked existing opportunity'
	    when type = 10 and type_name = 'Opportunity Lost' then 'lost opportunity'
	    when type = 9 and type_name = 'Opportunity Won' then 'won opportunity'
	    when type = 2 and type_name = 'Page View' then 'viewed highlighted page'
	    when type = 34 and type_name = 'Video' then 'watched 75% or more of video'
	    when type = 27 and type_name = 'Video' then 'watched video'
	    when type = 30 and type_name = 'Video' then 'converted from video call to action'
	    when type = 20 and type_name = 'Visit' then 'visited website'
	    when type = 25 and type_name = 'Webinar' then 'registered for webinar'
	    when type = 24 and type_name = 'Webinar' then 'attended webinar'
	    when type = 18 and type_name = '' then 'reopened opportunity'
	  end as event_action
	from
		olga_pardot.visitoractivity

);

create or replace view pardot.prospect_transformed as (

	select
		id 											as id,
		campaign_id 						as campaign_id,
		salutation 							as salutation,
		first_name 							as first_name,
		last_name 							as last_name,
		email 									as email,
		company 								as company,
		prospect_account_id 		as prospect_account_id,
		website 								as website,
		job_title 							as job_title,
		department 							as department,
		country 								as country,
		address_one 						as address_one,
		address_two 						as address_two,
		city 										as city,
		state 									as state,
		territory 							as territory,
		zip 										as zip,
		phone 									as phone,
		fax 										as fax,
		source 									as source,
		annual_revenue 					as annual_revenue,
		employees 							as employees,
		industry 								as industry,
		years_in_business 			as years_in_business,
		comments 								as comments,
		notes 									as notes,
		score 									as score,
		grade 									as grade,
		last_activity_at 				as last_activity_at,
		recent_interaction 			as recent_interaction,
		crm_lead_fid 						as crm_lead_fid,
		crm_contact_fid 				as crm_contact_fid,
		crm_owner_fid 					as crm_owner_fid,
		crm_account_fid 				as crm_account_fid,
		crm_last_sync 					as crm_last_sync,
		crm_url 								as crm_url,
		is_do_not_email 				as is_do_not_email,
		is_do_not_call 					as is_do_not_call,
		opted_out 							as opted_out,
		is_reviewed 						as is_reviewed,
		is_starred 							as is_starred,
		created_at 							as created_at,
		updated_at 							as updated_at
	from
		olga_pardot.prospect

);


create or replace view pardot.campaign_transformed as (

	select
		id													as id,
		cost												as cost,
		name												as name
	from
		olga_pardot.campaign

);


create or replace view pardot.opportunity_transformed as (

	select
		probability									as probability,
		campaign_id									as campaign_id,
		id													as id,
		name												as name,
		value												as value,
		updated_at									as updated_at,
		status											as status,
		created_at									as created_at,
		closed_at										as closed_at,
		stage												as stage,
		"type"											as "type"
	from
		olga_pardot.opportunity

);


create or replace view pardot.visit_transformed as (

	select
		duration_in_seconds					as duration_in_seconds,
		id													as id,
		last_visitor_page_view_at		as last_visitor_page_view_at,
		updated_at									as updated_at,
		first_visitor_page_view_at	as first_visitor_page_view_at,
		visitor_page_view_count			as visitor_page_view_count,
		created_at									as created_at,
		visitor_id									as visitor_id,
		content_parameter						as content_parameter,
		term_parameter							as term_parameter,
		medium_parameter						as medium_parameter,
		source_parameter						as source_parameter,
		prospect_id									as prospect_id,
		campaign_parameter					as campaign_parameter
	from
		olga_pardot.visit

);


create or replace view pardot.visitor_transformed as (

	select
		id													as id,
		prospect_id									as prospect_id
	from
		olga_pardot.visitor_filtered

);


create or replace view pardot.visitor_pageview_transformed as (

	select
		url													as url,
		id													as id,
		visit_id										as visit_id,
		title												as title,
		created_at									as created_at,
		visitor_id									as visitor_id
	from
		pardot.visitor_pageview_filtered

);


create or replace view pardot.visitor_referrer_transformed as (

	select
		vendor											as vendor,
		referrer										as referrer,
		id													as id,
		"type"											as "type",
		visitor_id									as visitor_id,
		query												as query,
		prospect_id									as prospect_id
	from
		pardot.visitor_referrer_filtered

);
