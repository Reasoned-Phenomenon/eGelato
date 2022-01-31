<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
			<th colspan="3">그룹 코드</th>
		</tr>
	</thead>
		 
	<tbody>
		<tr>
			<td>그룹 코드 이름 검색</td>
			<td><input type="text" id="inputName" name="inputName"></td>
			<td><button id="btnSearch">검색</button></td>
		</tr>
	</tbody>
</table>

<br>
<br>

<button onclick="window.open('${path}/com/comCode.do','공정이동표','width=800,height=600,location=no,status=no,scrollbars=no,titlebar=no,left=550,top=200');">새창에서</button>

<div>
	<h6>권한테스트</h6>
	
	<sec:authorize access="hasRole('ROLE_EQM')">
		ROLE_EQM
	</sec:authorize>	
	${gelatoRole }
</div>
<hr>
<br>
<div class="row">

	<div id="codeIdGrid" class="col-sm-4"></div>
	
	<div id="tabs" class="col-sm-8">
	
	  <ul>
	    <li><a href="#fragment-1">코드 조회</a></li>
	    <li><a href="#fragment-2">그룹 코드</a></li>
	  </ul>
	  
  		<div id="fragment-1" class="col-sm-8">
  			<div align="right">
	  			<button type="button" class="btn cur-p btn-outline-primary" id="btnAdd">코드 추가</button>
	  			<button type="button" class="btn cur-p btn-outline-primary" id="btnSave">저장</button>
  			</div>
  			<div id="codeGrid"></div>
  		</div>
  		
  		<div id="fragment-2" class="col-sm-8">
  				<iframe src="${path}/sym/ccm/cca/RegistCcmCmmnCodeView.do" 
				width="800" 
				height="400" 
				frameborder="0"></iframe>
  		</div>
  		
	</div>
	
</div>

<script>
//전역변수 선언
//클릭한 Row의 CodeId를 담기위한 전역변수
let codeParam;
//Response의 종류를 구분하기 위한 전역변수
let flag;

//그리드 선언
var Grid = tui.Grid;

//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	    },
	  }
});

toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 
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
			  rowSpan : true,
			  hidden:true
			},
			{
			  header: '그룹 코드',
			  name: 'codeId',
			  sortingType: 'desc',
	          sortable: true
			},
			{
			  header: '그룹 코드 이름',
			  name: 'codeIdNm'
			},
			{
			  header: '그룹 코드 상세',
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
	toastr.info('그룹 코드 선택','Gelato');
	
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
		  header: '그룹 코드',
		  name: 'codeId',
		  hidden:true
		},
		{
		  header: '이전코드',
		  name: 'bcode',
		  hidden:true
		},
		{
		  header: '코드',
		  name: 'code',
		  editor:'text',
          validation: {
              regExp: /^[a-zA-Z0-9]{1,6}$/
           }
		},
		{
		  header: '코드 이름',
		  name: 'codeNm',
		  editor:'text'
		},
		{
		  header: '코드 상세',
		  name: 'codeDc',
		  editor:'text'
		},
		{
		  header: '사용 여부',
		  name: 'useAt',
		  align: 'center',
		  renderer: {
	            type: GelatoRadio
	      } 
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
		//코드아이디 선택하지 않으면 행 추가 안 되게.
		if( typeof codeParam == 'undefined') {
			toastr.clear();
			toastr.info('코드ID를 선택하세요','Gelato');
			return;
		}
		//현재 선택된 row의 codeId값을 가진 row를 생성-> hidden
		codeGrid.appendRow({codeId:codeParam},{focus:true})
	})
	
	//조회버튼(검색) 
	btnSearch.addEventListener("click", function() {
		let targetName = document.getElementById("inputName").value;
		console.log(targetName)
		codeIdGrid.readData(1, {codeIdNm:targetName}, true);
	});
	
	$( "#tabs" ).tabs();
	
	//우측 그리드 클릭 이벤트
	codeGrid.on('click',function (ev) {
		console.log(ev)
	})
	
</script>
</body>
</html>