<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 코드 관리 페이지</title>
</head>
<body>
	<div class="container">
      <div class="flex row">
         <div class="col-4">
            <br>
            <h3>자재 코드 관리</h3>
            <div align="right">
               <button type="button" class="btn cur-p btn-outline-primary" id="SaveBtn">저장</button>
               <button type="button" class="btn cur-p btn-outline-primary" id="DelBtn">삭제</button>
               <button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
            </div>
            <div id="rwmatrGrid"></div>
         </div>

         <div class="col-8">
            <br>
            	<br>
            <table border="1">
               <tbody>
                  <tr>
                  
                     <th>자재코드*</th>
                     <td><input type="text" id="rwmatrId" name="rwmatrId"></td>
                     <th>자재명*</th>
                     <td><input type="text" id="nm" name="nm"></td>
                  </tr>
                  <tr>
                     <th>규격</th>
                     <td><input type="text" id="spec" name="spec"></td>
                     <th>관리단위</th>
                     <td><input type="text" id="" name=""></td>
                  </tr>
                  <tr>
                     <th>입고 업체</th>
                     <td><input type="text" id="vendId" name="vendId">
                        <button type="button" id="">검색</button></td>
                     <th>업체명</th>
                     <td><input type="text" id="vendName" name="vendName"></td>
                  </tr>
                  <tr>
                     <th>자재 계정</th>
                     <td><input type="text" id="" name="">
                        <button type="button" id="">검색</button> 
                        <input type="text" id="" name=""></td>
                     <th>자재 구분</th>
                     <td><input type="text" id="" name="">
                        <button type="button" id="">검색</button> 
                        <input type="text" id="" name=""></td>
                  </tr>
                  <tr>
                     <th>사용유무</th>
                     <td><input type="checkbox" id="useYn"></td>
                     <th>검사유무</th>
                     <td><input type="checkbox" id=""></td>
                  </tr>
                  <tr>
                     <th>LOT관리</th>
                     <td><input type="checkbox" id=""></td>
                     <th>안전재고 관리</th>
                     <td><input type="checkbox" id=""></td>
                  </tr>

               </tbody>
            </table>
         </div>
      </div>
   </div>

<script>
var Grid = tui.Grid;	


//그리드 테마.
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

//그리드 생성.
var rwmatrGrid = new Grid({
	el: document.getElementById('rwmatrGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/findRwmatrList.do', method: 'GET'},
	    
	  },
	  contentType: 'application/json',
	 
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	columns:[
			{
			  header: '자재 코드',
			  name: 'rwmatrId',
			  align: 'center'
		      
			},
			{
			  header: '자재 명',
			  name: 'nm',
			  align: 'center'
	          
			},
			{
			  header: '규 격',
			  name: 'spec',
			  align: 'center'
		      
			},
			{
			  header: '업체 코드',
			  name: 'vendId',
			  align: 'center',
			  hidden: true
			      
		   },
		   {
			  header: '작업 단위',
			  name: 'wkUnit',
			  align: 'center',
			  hidden: true
				      
	       },
	       {
			  header: '안전 재고',
			  name: 'safStc',
		      align: 'center',
		      hidden: true
					      
		   },
		]
});

//더블클릭시 한 행 선택 입력폼에 값 들어가게 하기.
		rwmatrGrid.on("dblclick", (ev) => {
			
			$("#rwmatrId").val(rwmatrGrid.getValue(ev["rowKey"],"rwmatrId"));
			$("#nm").val(rwmatrGrid.getValue(ev["rowKey"],"nm"));
			$("#spec").val(rwmatrGrid.getValue(ev["rowKey"],"spec"));
			$("#vendId").val(rwmatrGrid.getValue(ev["rowKey"],"vendId"));
			$("#vendName").val(rwmatrGrid.getValue(ev["rowKey"],"vendName"));
			
			rwmatrGrid.getValue(ev["rowKey"],"useYn")=='Y'?$("#useYn").prop("checked",true):$("#notUse").prop("checked",true);
			
			
		}) 
	
	</script>
	
	
	
</body>
</html>