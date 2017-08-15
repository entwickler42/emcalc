import QtQuick 1.0
import EmathListModel 1.0

Item{
	id: item
	
	property alias model: listView.model
	property alias currentItem: listView.currentItem
	property alias currentIndex: listView.currentIndex
	
	FontLoader { id: fixedFont; source: "qrc:/ResultFont" }		
	
	BorderImage {
		id: background	
		anchors.fill: item
		
		source: "qrc:/border_results"
		verticalTileMode: BorderImage.Stretch
		horizontalTileMode: BorderImage.Stretch
		border { left: 30; top: 30; right: 30; bottom: 30 }
		
		ListView{
			id: listView						
			anchors.fill: background; anchors.margins: 15
			spacing: 10; clip: true; focus: true; 
			model: dataModel
			flickDeceleration: 1000
								
			snapMode: ListView.SnapToItem
			highlightRangeMode: ListView.StrictlyEnforceRange
			highlightFollowsCurrentItem: true
			highlight: Rectangle { color: "lightblue"; radius: 3; width: parent.width - 10; anchors.margins: 0 }
			preferredHighlightBegin: height/2-15
			preferredHighlightEnd: height/2+15			
			
			delegate: Row {
				id: row
				width: parent.width - 20; height: listView.height / 6 - 10
				spacing: 5
				
				property alias text: labelValue.text
				property alias unitText: labelUnit.text
				property int fontSize: 28						
				
				Text{	
					id: labelValue
					width: row.width / 2
					text: unitValue
					color: "black"
					smooth: true
					styleColor: "white"
					style: Text.Outline
					font { pixelSize: parent.fontSize; family: fixedFont.name }
					
					onTextChanged: {
						if ( ListView.isCurrentItem && !(text.charAt(text.length-1) == ".") && !isNaN(text) ){
							dataModel.setData(currentIndex, text)
						}
					}
				}
				Text{
					id: labelUnit
					width: row.width / 2
					text: unitName
					color: "black"
					styleColor: "white"
					style: Text.Outline
					horizontalAlignment: Text.AlignRight
					font { pixelSize: parent.fontSize; family: fixedFont.name }
				}
			}
		}
	}
}

