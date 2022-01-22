<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
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
let codeParam;
let dialog;

var Grid = tui.Grid;

//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      /* background: '#fee' */
	      background: '#898989'
	    }
	  }
});

//코드ID 그리드(화면 좌측) 생성
const codeIdGrid = new Grid({
	el: document.getElementById('codeIdGrid'),
  	data : {
	  api: {
	    readData: 	{ url: '${path}/com/findComCode.do', method: 'GET'},
	    modifyData : { url: '${path}/com/comCodeModifyData.do', method: 'PUT'} 
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
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
			}
		]
});


//그리드 이벤트	
//클릭 이벤트
codeIdGrid.on('click', (ev) => {	
	
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
	toastr.options.positionClass = "toast-top-center";
	toastr.options.progressBar = true;
	toastr.success('코드ID선택','Gelato',{timeOut:'1500'});
	
});

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
		  formatter: 'listItemText',
		  editor : {
			  type: 'radio',
			  options: {
				  listItems: [
					  {text: 'Y', value: 'Y'},
					  {text: 'N', value: 'N'}
				  ]
			  }
		  }
		  
		}
     ]
});

	//응답시 이벤트
	codeGrid.on('response', function(ev) {
		console.log(ev)
	})
	
	//버튼 이벤트
	//저장버튼
	btnSave.addEventListener("click",function(){
		//수정하고 있던 값 저장
		codeGrid.blur()
		
		codeGrid.request('modifyData')
		
		/* var chkchk = new Promise((resolve, reject) => { 
			codeGrid.request('modifyData')
		})
		
		chkchk.then(codeGrid.readData(1)); */
		
	})	

	//추가버튼 -> 입력칸추가
	btnAdd.addEventListener("click",function(){
		
		console.log(codeParam)
		
		//현재 선택된 row의 codeId값을 가진 row를 생성-> hidden
		codeGrid.appendRow({codeId:codeParam},{focus:true})
	})
	
	//삭제버튼
	btnDel.addEventListener("click",function(){
		
		if(codeGrid.removeCheckedRows(true)){ //true -> 확인 받고 삭제 / false는 바로 삭제
			console.log("확인")
			codeGrid.request('modifyData');
		}
		
	})
	 
	btnSearch.addEventListener("click", function() {
		let targetName = document.getElementById("inputName").value;
		codeIdGrid.readData(1, {codeIdNm:targetName}, true);
	});

	//모달창
	$(function(){
		
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
		
	})
	
	function getModalData (str) {
		//목표 태그의 ID값을 입력하면 해당 태그의 value에 모달에서 가져온 값을 넣어줌.
		let target = document.getElementById('inputName');
		target.value = str;
		dialog.dialog( "close" );
	}
	
</script>
</body>
</html>