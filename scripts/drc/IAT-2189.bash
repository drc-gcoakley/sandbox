#!/bin/bash
#-------------------------------------------------------------------------------
script_client_list='louisiana,nebraska';
read -r -d '' script_content <<'EOF'
db.item.update({"subject": {"$in": [1,2]}},{"$set": {
	"toolsetDict": {
		"Protractors": {
			"Protractor": false
		},
		"Rulers": {
			"Quarter-Inch Ruler": false,
			"Eighth-Inch Ruler": false,
			"Sixteenth-Inch Ruler": false,
			"Centimeter Ruler": false
		},
		"Calculators": {
			"Basic Calculator": false,
			"Graphing Calculator": false,
			"Scientific Calculator": false
		}
	}
}},{"multi":true});
db.program.update({},{"$set": {
	"toolsetMaps": {
		1: {
			"Protractors": [
				"Protractor"],
			"Rulers":[
				"Quarter-Inch Ruler",
				"Eighth-Inch Ruler",
				"Sixteenth-Inch Ruler",
				"Centimeter Ruler"],
			"Calculators": [
				"Basic Calculator",
				"Graphing Calculator",
				"Scientific Calculator"]
		},
		2: {
			"Protractors": [
				"Protractor"],
			"Rulers":[
				"Quarter-Inch Ruler",
				"Eighth-Inch Ruler",
				"Sixteenth-Inch Ruler",
				"Centimeter Ruler"],
			"Calculators": [
				"Basic Calculator",
				"Graphing Calculator",
				"Scientific Calculator"]
		}
	}
}});
EOF
#-------------------------------------------------------------------------------