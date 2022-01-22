//페이지 이동시 메뉴 열리게 하는 부분
$(function () {
	$('a[href="'+window.location.pathname+'"]').parent().parent().parent().find('a').trigger("click")
})

//라디오 렌더러
class GelatoRadio {
  constructor(props) {
	console.log(props)
	const { grid, rowKey,columnInfo, value } = props;
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

//셀렉트 렌더러
class GelatoSelect {
  constructor(props) {
	
	console.log(props)
	//console.log(props.columnInfo.renderer.options)
	
	const { grid, rowKey,columnInfo, value } = props;
	
	const el = document.createElement('select');
	
	let data = props.columnInfo.editor.options.listItems;
	
	for(let i = 0 ; i < data.length ; i ++) {
		let opt = document.createElement('option');
		opt.innerText = data[i].text;
		opt.value = data[i].value;
		el.append(opt);
	}
	
	el.addEventListener('click',function (ev) {
		console.log(ev)
		ev.stopPropagation();
	})
	
    this.el = el;
  }

  getElement() {
    return this.el;
  }

	render(props) {
		this.el.value = String(props.value);
	}
}

//셀렉트 에디터
class GelatoSelectEditor {
  constructor(props) {
	
	console.log(props)
	
	//const { grid, rowKey,columnInfo, value } = props;
	
	const el = document.createElement('select');
	
	let data = props.columnInfo.editor.options.listItems;
	
	for(let i = 0 ; i < data.length ; i ++) {
		let opt = document.createElement('option');
		opt.innerText = data[i].text;
		opt.value = data[i].value;
		el.append(opt);
	}
	
	el.addEventListener('click',function (ev) {
		console.log(ev)
		ev.stopPropagation();
	})
	
    this.el = el;
  }

  getElement() {
    return this.el;
  }

  getValue() {
    return this.el.value;
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