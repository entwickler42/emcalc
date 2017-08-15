import QtQuick 1.0


Rectangle {
	id: screen
	width: 640; height: 340;
	color: "black"	
	
	property bool overwrite: true
	property bool exit: false
	
	function isPortrait() { return (width < height) }

	BorderImage {
		anchors.fill: parent
		border { left: 20; top: 20; right: 20; bottom: 20 }
		horizontalTileMode: BorderImage.Stretch
		verticalTileMode: BorderImage.Stretch
		source: "qrc:/border_screen"
	}

	ResultDisplay{
		id: resultDisplay
		anchors {
			left: parent.left; right: parent.horizontalCenter
			top: parent.top; bottom: parent.bottom
			leftMargin: 25; rightMargin: 10; topMargin: 25; bottomMargin: 20
		}
		
		onCurrentItemChanged: {
			screen.overwrite = true
		}
	}

	KeyPad{
		id: keyPad
		anchors {
			left: parent.horizontalCenter; right: parent.right
			top: parent.top; bottom: parent.bottom
			leftMargin: 10; rightMargin: 35; topMargin: 35; bottomMargin: 35
		}

		onClear: {
			resultDisplay.currentItem.text = "0.0"
			screen.overwrite = true
			if( screen.exit ){
				Qt.quit()
			}else{
				screen.exit = true
			}
		}
		onBackspace: {			
			resultDisplay.currentItem.text = resultDisplay.currentItem.text.slice(0, resultDisplay.currentItem.text.length-1)
			screen.exit = false
		}
		onScaleUp: {
			resultDisplay.currentItem.text *= 10.0;
			screen.exit = false
		}
		onScaleDown: {
			resultDisplay.currentItem.text *= 0.1;
			screen.exit = false
		}
		onInvertSign: {
			resultDisplay.currentItem.text *= -1.0;
			screen.exit = false
		}
		onPressed: {			
			screen.exit = false
			if( screen.overwrite ){
				screen.overwrite = false
				resultDisplay.currentItem.text = text
			}else{
				resultDisplay.currentItem.text += text
			}
		}
	}

	states:
		State {
		name: "Portrait"
		when: isPortrait()
		PropertyChanges {
			target: resultDisplay
			anchors {
				left: parent.left; right: parent.right
				top: parent.top; bottom: parent.verticalCenter
				leftMargin: 25; rightMargin: 25; topMargin: 25; bottomMargin: 5
			}
		}
		PropertyChanges {
			target: keyPad
			anchors {
				left: parent.left; right: parent.right
				top: parent.verticalCenter; bottom: parent.bottom
				leftMargin: 35; rightMargin: 35; topMargin: 5; bottomMargin: 35
			}
		}
	}
}
