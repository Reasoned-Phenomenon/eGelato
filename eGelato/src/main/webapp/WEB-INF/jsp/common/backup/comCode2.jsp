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

<!-- model popup -->
<!-- The Modal -->
<div class="modal fade" id="myModal">
   <div class="modal-dialog">
      <div class="modal-content">
         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">공통 코드 조회</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
         <!-- Modal body -->
         <div class="modal-body">
         <button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
            <div id="modalGrid"></div>
         </div>
         <!-- Modal footer -->
         <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
         </div>
      </div>
   </div>
</div>
<!-- end model popup -->
<br>

<div align="right">
<button type="button" class="btn cur-p btn-outline-primary" id="btnAdd">CODE 추가</button>
<button type="button" class="btn cur-p btn-outline-primary" id="btnSave">저장</button>
<button type="button" class="btn cur-p btn-outline-primary" id="btnDel">삭제</button>

<button type="button" class="model_bt btn btn-primary" data-toggle="modal" data-target="#myModal" id="">Modal</button>
</div>

<hr>
<br>
<div class="row">
	<div id="codeIdGrid" class="col-sm-4"></div>
	<div id="codeGrid" class="col-sm-8"></div>
</div>

<script>
let codeParam;

var Grid = tui.Grid;

//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	    }
	  }
});

//코드ID 그리드 생성
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
			  header: '코드ID',
			  name: 'codeId',
			  sortingType: 'desc',
	          sortable: true
			},
			{
			  header: '코드ID이름',
			  name: 'codeIdNm'
			},
			{
			  header: '코드ID이름',
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
	codeGrid.readData(1, {codeId:codeIdGrid.getRow(ev.rowKey).codeId}, true);
	
});

//응답시 이벤트
codeIdGrid.on('response', function(ev) {
	console.log('response')
	console.log(ev)
})
	
//코드 그리드 생성	
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
		  copyOptions: {
	            useListItemText: true
	      },
		  formatter: 'listItemText',
		  editor: {
		      type: 'radio',
		      options: {
		        listItems: [
		          { text: 'Y', value: 'Y' },
		          { text: 'N', value: 'N' }
		        ]
		      }
		    }
		}
     ]
});

	//버튼 이벤트
	btnSave.addEventListener("click",function(){
		codeGrid.request('modifyData');
	})	

	btnAdd.addEventListener("click",function(){
		console.log(codeParam)
		//현재 선택된 row의 codeId값을 가진 row를 생성
		codeGrid.appendRow({codeId:codeParam},{focus:true})
	})
	
	btnDel.addEventListener("click",function(){
		//removeRow(rowKey, options)
		codeGrid.removeCheckedRows(true); //true -> 확인 받고 삭제 / false는 바로 삭제
		codeGrid.request('modifyData');
	})
	 
	btnSearch.addEventListener("click", function() {
		let targetName = document.getElementById("inputName").value;
		codeIdGrid.readData(1, {codeIdNm:targetName}, true);
	})

	//모달창
	let dialog = $( "#dialog-form" ).dialog({

		
	})




</script>
</body>
</html>