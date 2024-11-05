class_name NotebookResource
extends Resource

enum topic_flags{
	DISCOVERED,
	CLICKED
}



var topics:Dictionary = {
	"hello" : {
		"timeline": "test_timeline",
		"label": "hello",
		"discovered": true,
		"clicked": false,
	},
	"information" : {
		"timeline": "test_timeline",
		"label": "information",
		"discovered": true,
		"clicked": false,		
	}
}