class_name NotebookResource
extends Resource

enum topic_flags{
	DISCOVERED,
	CLICKED
}



var notebook_topics:Dictionary = {
	"hello" : {
		"discovered": true,
		"clicked": false,
	},
	"information" : {
		"discovered": true,
		"clicked": false,		
	}
}