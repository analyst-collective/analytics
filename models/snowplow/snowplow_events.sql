select
	"collector_tstamp"          as "@timestamp",
	"event_name"                as "@event",
	"domain_userid"             as "@user_id",
	*
from
	atomic.events
