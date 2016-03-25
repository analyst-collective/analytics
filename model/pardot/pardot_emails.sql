/*
This model maps pardot data from the visitoractivity table to the email analysis interface.
It conforms to the basic email interface, not the extended email interface, because Pardot does not supply
data necessary to conform to the extended interface.
*/

select "@timestamp", "@event", "@user_id", email_id as "@email_id", details as "@subject"
	from {{env.schema}}.pardot_visitoractivity
where "@event" in ('email sent', 'email opened', 'email click')
