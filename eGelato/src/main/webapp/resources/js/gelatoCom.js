//라디오 렌더러
class GelatoRadio {
  constructor(props) {
	
	
	const { grid, rowKey,columnInfo, value } = props;
	//console.log(grid)
	//console.log(rowKey)
	//console.log(columnInfo)
	//console.log(value)
	const el = document.createElement('div');
	
    const input1 = document.createElement('input');
	const input2 = document.createElement('input');

	const label = document.createElement('label');
	const label2 = document.createElement('label');
	
    input1.type = 'radio';
	input1.name = rowKey;
    input1.value ='Y';
    input1.id ='Y';

    label.for = 'Y';
    label.innerText = 'Yes'; 

    input2.type = 'radio';
	input2.name = rowKey;
    input2.value ='N';
    input2.id ='N';

    label2.for = 'N';
    label2.innerText = 'No';

	if(value == 'Y') {
    	input1.checked = true;
	} else if (value == 'N') {
		input2.checked = true;
	}
	
	el.append(input1,label)
	el.append(input2,label2)
	
	el.addEventListener('change',function(ev){
		if(input1.checked) { 
			grid.setValue(rowKey, columnInfo.name, "Y");
		} else if (input2.checked) {
			grid.setValue(rowKey, columnInfo.name, "N");
		}
	})
		
    this.el = el;
  }

  getElement() {
    return this.el;
  }

}

//로트번호 부여 함수
function get_lot(str_id) {
	
	let seq,dt;
	
	$.ajax({
		url:"mkLot.do?itemId="+str_id,
		async:false,
		error: function (result) {
			console.log('에러발생',result)
		}
	}).done(function (result) {
		console.log(result)
		seq = result.seq;
		dt = result.dt;
	})
	
	return [seq,dt];
}

console.log("gelatoCom.js실행")