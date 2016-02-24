create or replace view pardot_analysis.visitoractivity_transformed as (
	--this table has a bunch of types that really should be event actions but are very poorly formulated.
	--the custom logic in this view is an attempt to fix that.
	--not all of the various type / type_name combinations have been accounted for yet; I still need to determine exactly what some of them mean.
	select
		va.campaign_id							as campaign_id,
		va.form_handler_id					as form_handler_id,
		va.id												as id,
		va.email_id									as email_id,
		va.type_name								as type_name,
		va."type"										as "type",
		va.details									as details,
		va.created_at								as created_at,
		va.prospect_id							as prospect_id,
		va.visitor_id								as visitor_id,
		va.opportunity_id						as opportunity_id,
		t.type_decoded							as type_decoded,
		e.event_name								as event_name
	from
		pardot_analysis.visitoractivity_filtered va
		inner join pardot_analysis.visitoractivity_events_meta e
			on va.type = e.type and va.type_name = e.type_name
		inner join pardot_analysis.visitoractivity_types_meta t
			on va.type = t.type

);

create or replace view pardot_analysis.prospect_transformed as (

	select
		id 											as id,
		campaign_id 						as campaign_id,
		salutation 							as salutation,
		first_name 							as first_name,
		last_name 							as last_name,
		email 									as email,
		company 								as company,
		website 								as website,
		job_title 							as job_title,
		department 							as department,
		country 								as country,
		address_one 						as address_one,
		city 										as city,
		state 									as state,
		territory 							as territory,
		zip 										as zip,
		phone 									as phone,
		fax 										as fax,
		source 									as source,
		annual_revenue 					as annual_revenue,
		industry 								as industry,
		comments 								as comments,
		notes 									as notes,
		score 									as score,
		grade 									as grade,
		last_activity_at 				as last_activity_at,
		recent_interaction 			as recent_interaction,
		crm_lead_fid 						as crm_lead_fid,
		crm_contact_fid 				as crm_contact_fid,
		crm_owner_fid 					as crm_owner_fid,
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
		pardot_analysis.prospect_filtered

);


create or replace view pardot_analysis.opportunity_transformed as (

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
		pardot_analysis.opportunity_filtered

);
