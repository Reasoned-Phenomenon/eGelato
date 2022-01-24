<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
</head>
<body>
<h3>공통 코드 관리</h3>
  
<table border="1">
	<thead>
		<tr>
			<th colspan="2">코드</th>
		</tr>
	</thead>
		 
	<tbody>
		<tr>
			<td>이름 검색</td>
			<td><input type="text" id="inputName" name="inputName"></td>
			<td><button id="btnSearch">검색</button></td>
		</tr>
	</tbody>
</table>
<button id="btnTest">검색</button>
<button id="btnAjax">Ajax</button>

<br>
<input id="testInput" type="time">시간입력
<button id="btnTime">시간확인</button>
<div id="bcTarget"></div> 
<br>
 
<div align="right">
	
	<button type="button" class="btn cur-p btn-outline-primary" id="btnModal">모달창 테스트</button>
	<button type="button" class="btn cur-p btn-outline-primary" id="btnAdd">CODE 추가</button>
	<button type="button" class="btn cur-p btn-outline-primary" id="btnSave">저장</button>
	<button type="button" class="btn cur-p btn-outline-primary" id="btnDel">삭제</button>
</div>

<div id="dialog-form" title="모달창 테스트">여기에</div>

<hr>
<br>
<div class="row">

	<div id="codeIdGrid" class="col-sm-4"></div>
	
	<div id="tabs" class="col-sm-8">
	
	  <ul>
	    <li><a href="#fragment-1">조회</a></li>
	    <li><a href="#fragment-2">입력</a></li>
	  </ul>
	  
  		<div id="fragment-1" class="col-sm-8">
  			<div id="codeGrid"></div>
  		</div>
  	
		<div id="fragment-2" class="col-sm-8">
			<div>입력폼</div>
		</div>
		
	</div>
	
</div>

<script>
//전역변수 선언
//클릭한 Row의 CodeId를 담기위한 전역변수
let codeParam;
//모달
let dialog;
//Response의 종류를 구분하기 위한 전역변수
let flag;


//$("#bcTarget").barcode("PID-20220102-001", "code128",{barWidth:2, barHeight:70});  

var Grid = tui.Grid;

//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	      //background: '#898989'
	    },
	    /* selectedHeader : {
	    	background : '#FFFFFF'
	    }, 
	    selectedRowHeader : {
	    	background : '#FFFFFF'
	    } */
	  }
});

toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
		}
		
let daeche = [];
let dataSources = {
		  api: {
			    readData: 	{ url: '${path}/com/findComCode.do', method: 'GET'},
			    modifyData : { url: '${path}/com/comCodeModifyData.do', method: 'PUT'} 
			  },
			  contentType: 'application/json'
			};
//코드ID 그리드(화면 좌측) 생성
var codeIdGrid = new Grid({
	el: document.getElementById('codeIdGrid'),
  	data : dataSources,
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
  			{
			  header: 'CL 코드',
			  name: 'clCode',
			  rowSpan : true
			},
			{
			  header: '코드 ID',
			  name: 'codeId',
			  sortingType: 'desc',
	          sortable: true
			},
			{
			  header: '코드 ID 이름',
			  name: 'codeIdNm'
			},
			{
			  header: '코드 ID 상세',
			  name: 'codeIdDc',
			  hidden:true
			},
			
		]
});


//그리드 이벤트	
//클릭 이벤트
codeIdGrid.on('click', (ev) => {	
	console.log(ev)
	//cell 선택시 row 선택됨.
	codeIdGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, codeIdGrid.getColumns().length-1]
	  });
	
	//클릭한 row의 codeId에 해당하는 code를 읽어옴
	codeParam = codeIdGrid.getRow(ev.rowKey).codeId;
	codeGrid.readData(1, {codeId:codeParam}, true);
	
	//토스트
	toastr.clear()
	toastr.info('코드ID선택','Gelato');
	//toastr.info('코드ID선택 <button type="button">테스트1</button><br><button type="button">테스트2</button>','Gelato');
	
});

	//Ajax 버튼 클릭시
	btnAjax.addEventListener('click',function () {
		$.ajax({
			url:'${path}/com/findComCode.do',
			dataType:'json',
			success: function (res) {
				
				let ff ;
				for(let i =0 ; i< res.data.contents.length ; i ++) {
					
					if( i == 0) {
						ff = res.data.contents[i].codeId;
					}
					
					if(ff == res.data.contents[i].codeId) {
						daeche.push(res.data.contents[i]);
						console.log("같음")
					} else {
						let chuga = {
								clCode: '',
								codeId: '',
								codeIdNm: '소계 테스트',
								codeIdDc: '',
						};
						daeche.push(chuga);
						daeche.push(res.data.contents[i]);
						console.log("다름")
					}
				}
				
				codeIdGrid.resetData(daeche);
				codeIdGrid.resetOriginData();
			}
		})
	})



//코드 그리드(화면 우측) 생성	
const codeGrid = new tui.Grid({
	el: document.getElementById('codeGrid'),
	data: {
			api: {
			    readData: 	{url: '${path}/com/findComCodeDeta.do', method: 'GET' },
			    modifyData : { url: '${path}/com/comCodeDetaModifyData.do', method: 'PUT'} 
		  	},
			contentType: 'application/json',
			initialRequest: false
	},
	rowHeaders:['checkbox'],
  	selectionUnit: 'row',
    columns: [
    	{
		  header: '코드ID',
		  name: 'codeId',
		  hidden:true
		},
		{
		  header: '이전코드',
		  name: 'bcode',
		  hidden:true
		},
		{
		  header: 'CODE',
		  name: 'code',
		  editor:'text',
          validation: {
              regExp: /^[a-zA-Z0-9]{1,6}$/
           }
		},
		{
		  header: 'CODE_NM',
		  name: 'codeNm',
		  editor:'text'
		},
		{
		  header: 'CODE_DC',
		  name: 'codeDc',
		  editor:'text'
		},
		{
		  header: 'USE_AT',
		  name: 'useAt',
		  align: 'center',
		  editor: {
	            type: GelatoSelectEditor,
	            options: {
	            	listItems : [
	            		{text: '사용', value: 'Y'},
						{text: '비사용', value: 'N'},
	            		]
	            }
	      },
	      renderer: {
	            type: GelatoSelect
	      } 
		  /* formatter: 'listItemText',
		  editor : {
			  type: 'select',
			  options: {
				  listItems: [
					  {text: '사용', value: 'Y'},
					  {text: '비사용', value: 'N'}
				  ]
			  }
		  },*/
		  
		  
		}
     ]
});

	//응답시 이벤트
	codeGrid.on('response', function(ev) {
		console.log('response',ev)
		if(flag == 'O') {
			codeGrid.readData(1);
			flag = 'X';
		}
	})
	
	//버튼 이벤트
	//저장버튼
	btnSave.addEventListener("click",function(){
		//수정하고 있던 값 저장
		if(confirm("저장하시겠습니까?")) {
			codeGrid.blur()
			codeGrid.request('modifyData',{showConfirm:false})
			flag = 'O';
		}
		
	})	

	//추가버튼 -> 입력칸추가
	btnAdd.addEventListener("click",function(){
		
		console.log(codeParam)
		
		//현재 선택된 row의 codeId값을 가진 row를 생성-> hidden
		codeGrid.appendRow({codeId:codeParam},{focus:true})
	})
	
	//삭제버튼
	btnDel.addEventListener("click",function(){
		
		if(confirm("삭제하시겠습니까?")){ 
			codeGrid.removeCheckedRows(false) //true -> 확인 받고 삭제 / false는 바로 삭제
			codeGrid.request('modifyData',{showConfirm:false});
		}
		
	})
	 
	btnSearch.addEventListener("click", function() {
		let targetName = document.getElementById("inputName").value;
		codeIdGrid.readData(1, {codeIdNm:targetName}, true);
	});

	//모달창
	//dialog는 상단에 전역변수로 선언해뒀음
	//모달생성
	dialog = $( "#dialog-form" ).dialog({
	      autoOpen: false,
	      height: 500,
	      width: 700,
	      modal: true,
	      buttons: {
	          Cancel: function() {
	            dialog.dialog( "close" );
	          }
	      }
	     
	});
	
	//모달 호출하는 버튼
	btnModal.addEventListener("click",function(){
		
		console.log("모달클릭")
		dialog.dialog( "open" );
		console.log(codeParam)
		
		 $('#dialog-form').load("${path}/com/comModal.do",function () {
			console.log('로드됨')
			modalGrid.readData(1, {codeId:codeParam}, true);
		})
		
	})
	
	$( "#tabs" ).tabs();
		
	function getModalData (str) {
		//목표 태그의 ID값을 입력하면 해당 태그의 value에 모달에서 가져온 값을 넣어줌.
		let target = document.getElementById('inputName');
		target.value = str;
		dialog.dialog( "close" );
	}
	
	//테스트
	//LOT 번호 부여 테스트
	btnTest.addEventListener('click', function () {
		let a = get_lot('RML-10010')
		console.log(a)
		
	})
	
	codeGrid.on('click',function (ev) {
		//findRows로 중복값 체크 -> 번호 증가시키면 LOT번호 부여 가능할 것 같음
		console.log(ev)
		/* let aaa = codeGrid.findRows({
			code:codeGrid.getValue(ev.rowKey,ev.columnName)
		}) 
		console.log(aaa.length) */
	})
	
	//input태그(time) 테스트
	btnTime.addEventListener('click', function () {
		
		let now = new Date();
		
		testInput.value = ("00"+now.getHours()).slice(-2)+":"+("00"+now.getMinutes()).slice(-2);
		
		console.log(testInput.value)
		
	})
	
</script>
</body>
</html>