select
	"timestamp"::timestamp  as "@timestamp",
	"event"                 as "@event",
	"userid"                as "@user_id",
	*

from
	segment.track
