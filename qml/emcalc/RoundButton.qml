import QtQuick 1.0

Item{
	id: roundButton
	
	property alias text : label.text 
	
	signal clicked()
	
	Image{
		id: image
		anchors.fill: parent		
		smooth: true
		source: "qrc:/button_up"		
		fillMode:  Image.PreserveAspectFit
	}
	
	Text{
		id: label
		anchors.centerIn: parent		
		color: "white"
		smooth: true
		style: Text.Outline
		font { bold: true; pixelSize: parent.height * 0.35 }
	}
	
	MouseArea{
		id: mouseArea
		
		anchors.fill: parent		
		onClicked: roundButton.clicked()		
	}
	
	states: [
		State {
			name: "pressed"
			when: mouseArea.pressed
			
			PropertyChanges {
				target: image
				source: "qrc:/button_down"					
			}
			PropertyChanges {
				target: label		
				color: "yellow"
				font { bold: true; pixelSize: parent.height * 0.45 }
			}			
		}
	]
}

