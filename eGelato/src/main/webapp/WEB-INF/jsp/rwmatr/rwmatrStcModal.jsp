<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재고 목록</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>현재고 목록</h1><br>
	<div>
		<form action="">
		    <table>
		        <tbody>
		            <tr>
		                <th>자재명</th>
		                <td><input type="text" id="rwmNameStcM"></td>
		            </tr>
		            <tr>
		                <th>자재코드</th>
		                <td><input type="text" id="rwmatrSid"></td>
		                <td><button type="button" id="rwmatrSearch" class="btn cur-p btn-dark">조회</button></td>
		                <td><button type="reset" class="btn cur-p btn-dark">초기화</button></td>
		            </tr>
		        </tbody>
		    </table>
	    </form>
	</div>
	
	<div id="rwmatrStcListGrid" style="width: 100%"></div><br>
	
	<div style="text-align: center;">
		<button type="button" class="btn btn-secondary" id="btnchoose">확인</button>
		<button type="button" class="btn btn-secondary" id="btnExit">취소</button>
	</div>
	
	
<script>
var Grid = tui.Grid;

var rwmNameStcM;
var rwmatrSid;

//자재명검색
document.getElementById("rwmatrSearch").addEventListener("click", function () {
	rwmNameStcM = document.getElementById("rwmNameStcM").value;
	rwmatrSid = document.getElementById("rwmatrSid").value;
	console.log(rwmNameStcM);
	console.log(rwmatrSid);
	rwmatrStcListGrid.readData(1,{'rwmName':rwmNameStcM,
								  'rwmatrId':rwmatrSid}, true);
});

// 그리드 생성
var rwmatrStcListGrid = new Grid({
	el: document.getElementById('rwmatrStcListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrStcMList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum','checkbox'],
  	bodyHeight: 405,
  	selectionUnit: 'row',
  	columns:[
 		  {
		    header: '발주디테일코드',
		    name: 'rwmatrOrderDetaId',
		    hidden:true
		  },
  		  {
		    header: '자재LOT번호',
		    name: 'lotNo',
		    sortable: true
		  },
  		  {
		    header: '자재코드',
		    name: 'rwmatrId',
		    sortable: true
		  },
		  {
		    header: '자재명',
		    name: 'nm',
		    sortable: true
		  },
		  {
		    header: '업체명',
		    name: 'vendName',
		    sortable: true
		  },
		  {
		    header: '수량',
		    align: 'right',
		    name: 'qy',
		    formatter({value}) { // 추가
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			      return b;
			  },
		    sortable: true,
	        validation: {
	        	validatorFn: (value, row, columnName) => Number(value) > Number(row['safStc'])
	        }
		  },
		  {
		    header: '유통기한',
		    name: 'expdate',
		    sortable: true
		  }
		]
});

//커스텀 이벤트
$("#btnchoose").on("click", function(){
			
	
	let stc = rwmatrStcListGrid.getCheckedRows();
	console.log(stc);
	
	for(let i=0; i < stc.length; i++) {
		rwmatrOustList.prependRow({'lotNo':stc[i].lotNo, 
								   'rwmatrOrderDetaId':stc[i].rwmatrOrderDetaId, 
								   'rwmatrId':stc[i].rwmatrId, 
								   'nm':stc[i].nm,
								   'qy':stc[i].qy,
								   'vendName':stc[i].vendName,
								   'expdate':stc[i].expdate})
	}
	
	rwmatrStcDialogFrm.dialog( "close" );
	
});

$("#btnExit").on("click", function(){
	
	rwmatrStcDialogFrm.dialog( "close" );
	
});

</script>
</body>
</html>