import QtQuick 1.0

Item {
	id: keyPad
	
	signal quit()
	signal clear()
	signal scaleUp()
	signal scaleDown()
	signal invertSign()
	signal backspace()
	signal pressed(string text)
	
	function handleClick(text)
	{
		switch(text){
		case "C":
			backspace()
			break
		case "AC":
			clear()
			break
		case "<":
			scaleUp()
			break
		case ">":
			scaleDown()
			break
		case "-":
			invertSign()
			break			
		default:
			pressed(text)		
			break
		}		
	}
	
	function translateIndex(index)
	{
		switch(index){
		case 0:  return "7"
		case 1:  return "8"
		case 2:  return "9"
		case 3:  return "AC"
		case 4:  return "4"
		case 5:  return "5"
		case 6:  return "6"			
		case 7:  return "C"
		case 8:  return "1"
		case 9:  return "2"
		case 10: return "3"
		case 11: return ">"
		case 12: return "-"
		case 13: return "0"
		case 14: return "."
		case 15: return "<"		
		}
		return "?"
	}
	
	Grid{
		id: grid
		anchors.fill: parent
		rows: 4; columns: 4; spacing: 2
		
		Repeater{			
			id: buttons
			model: 16			
			
			RoundButton{				
				width:  keyPad.width / 4 - grid.spacing
				height: keyPad.height / 4 - grid.spacing				
				text: translateIndex(index)
				
				onClicked: handleClick(text);
			}
		}
	}
}
