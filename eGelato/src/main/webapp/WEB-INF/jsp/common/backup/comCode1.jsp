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
<form>
<table border="1">
	<thead>
		<tr>
			<th>코드ID</th>
			<th>코드</th>
		</tr>
	</thead>
		
	<tbody>
		<tr>
			<td>코드ID</td>
			<td>코드 : <input type="text" id="" name=""></td>
		</tr>
	</tbody>
</table>
</form>
<br>

<button type="button" class="btn cur-p btn-outline-primary" id="btnSave">저장</button>
<button type="button" class="btn cur-p btn-outline-primary" id="btnAdd">추가</button>
<button type="button" class="btn cur-p btn-outline-primary" id="btnDel">삭제</button>

<button type="button" class="model_bt btn btn-primary" data-toggle="modal" data-target="#myModal" id="">Modal</button>

<hr>
<br>
<div id="grid"></div>

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
<script>
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

//그리드 컬럼	
const columns = [
			/* {
			  header: 'CL코드',
			  name: 'clCode'
			}, */
			{
			  header: '코드ID',
			  name: 'codeId',
			  sortingType: 'desc',
	          sortable: true,
	          validation: {
	              regExp: /^[a-zA-Z0-9]{1,6}$/
	           },
	           editor:'text'
			},
			/* 
			{
			  header: '코드ID이름',
			  name: 'codeIdNm',
			  editor: 'text'
			},
			{
			  header: '코드ID상세설명',
			  name: 'codeIdDc',
			  editor: 'text'
			},
			{
			    header: '코드ID 사용여부',
			    name: 'codeIdUseAt',
			    align:'center',
			    editor: 'checkbox'
			 }, */
			 {
				  header: '코드',
				  name: 'code',
				  editor: 'text'
			},
			{
				  header: '코드이름',
				  name: 'codeNm',
				  editor: 'text'
			},
			{
				  header: '코드상세',
				  name: 'codeDc',
				  editor: 'text'
			},
			{
			    header: '코드 사용여부',
			    name: 'codeUseAt',
			    align:'center',
			    editor: 'checkbox'
			 }
		];


	//그리드 데이터
	const dataSource = {
			
		  api: {
		    readData: 	{ 	
		    				url: '${path}/com/findComCode.do', 
					    	method: 'GET'
		    			},
		    modifyData : { 	
							url: '${path}/com/comCodeModifyData.do', 
					    	method: 'PUT'
						} 
		  },
		  
		  contentType: 'application/json'
		  
	};
		
	//그리드 생성
	const grid = new Grid({
	  el: document.getElementById('grid'),
	  data : dataSource,
	  rowHeaders:['rowNum','checkbox'],
	  columns
	});

//그리드 이벤트	
	grid.on('click', (ev) => {
	  	console.log('clicked!!');
		console.log(ev)
	});
	
	grid.on('response', function(ev) {
		console.log('response')
		console.log(ev)
	})
	
	btnSave.addEventListener("click",function(){
		grid.request('modifyData');
	})	

	btnAdd.addEventListener("click",function(){
		grid.appendRow({
			"clCode": "GEL",
			"useAt":"Y"
		},{focus:true})
	})
	
	btnDel.addEventListener("click",function(){
		//removeRow(rowKey, options)
		grid.removeCheckedRows(true); //true -> 확인 받고 삭제 / false는 바로 삭제
		grid.request('modifyData');
	})
	
	let testData = [{
			  api: {
			    readData: 	{ 	
			    				url: '${path}/com/findComCodeDeta.do', 
						    	method: 'GET'
			    			},
			    modifyData : { 	
								url: '${path}/com/comCodeDetaModifyData.do', 
						    	method: 'PUT'
							} 
			  },
			  contentType: 'application/json'
		}];
	
	 const modalGrid = new tui.Grid({
	      el: document.getElementById('modalGrid'),
	      data: testData,
	      width: 450,
	      bodyHeight:200,
	      columns: [
	        {
	          header: 'CODE_ID',
	          name: 'CODE_ID'
	        },
	        {
	          header: 'CODE',
	          name: 'CODE'
	        },
	        {
	          header: 'CODE_NM',
	          name: 'CODE_NM'
	        },
	        {
	          header: 'CODE_DC',
	          name: 'CODE_DC'
		    },
	        {
	          header: 'USE_AT',
	          name: 'USE_AT',
	          align: 'center'
			}
	      ]
	    });
	 
	btnFind.addEventListener('click',function (ev) {
		console.log(ev)
		fetch("${path}/com/comCodeDetaCodeId.do", {
		  method: 'POST',
		  body: JSON.stringify({codeId:"INF001"}),
		  headers:{
		    'Content-Type': 'application/json'
		  }})
		.then(res=>res.json())
		.then(result=> {
			console.log(result)
			testData = result
			modalGrid.resetData(testData);
		})
	})
	
	/* fetch("${path}/com/comCodeDetaCodeId.do",{codeId:"INF001"})
	.then(res=>res.json())
	.then(result=> {
		console.log("여기~~")
		console.log(result)
	}) */
	
	grid.on("afterChange",function(ev){
		console.log("변경됨")
		console.log(ev.changes)
	})
	
</script>
</body>
</html>