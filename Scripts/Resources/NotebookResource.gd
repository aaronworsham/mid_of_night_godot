class_name NotebookResource
extends Resource

enum topic_flags{
	DISCOVERED,
	CLICKED
}



var topics:Dictionary = {
	"hello" : {
		"discovered": true,
		"clicked": false,
	},
	"information" : {
		"discovered": true,
		"clicked": false,		
	}
}