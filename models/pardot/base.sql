create or replace view pardot_analysis.visitoractivity_base as (

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
		opportunity_id							as opportunity_id
	from
		olga_pardot.visitoractivity

);


create or replace view pardot_analysis.prospect_base as (

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
		olga_pardot.prospect

);


create or replace view pardot_analysis.opportunity_base as (

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
