<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- 제이쿼리 UI -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<!-- 바코드 -->
<script src="${path}/resources/js/jquery-barcode.js" type="text/javascript"></script>

<body>
	<br><br>
	<h2 style = 'text-align: center;'>공정이동표</h2>
	<br>
	
	<div id="bcTarget" ></div> 
	<div>
		<table>
		<tbody>
			<tr>
				<th>라인코드</th>
				<td id="lineId"></td>
				<th>제품코드</th>  
				<td id="prdtId"></td>
			</tr>
			<tr>
				<th>제품명</th>
				<td id="prdtNm"></td>
				<th>수량</th>
				<td id="qy"></td>
			</tr>
		</tbody>
		</table>
	</div>
	
	<button type="button" class="btn btn-secondary" id="btnPrint" >인쇄</button>
</body>

<script>
	//onclick="window.print()"
	let mid = '${param.mid}';
	console.log(mid);
	
	$("#bcTarget").barcode(mid, "code128",{barWidth:3, barHeight:50});  
	
	$.ajax({
		url : "${path}/prd/prdtMoveInfo.do?indicaDetaId="+mid,
		dataType : 'json',
		error : function(result) {
			console.log('에러', result)
		}
	}).done(function(result) {
		console.log('확인');
		console.log(result);
		console.log(result.data.contents[0].lineId);
		console.log(result.data.contents[0].prdtId);
		console.log(result.data.contents[0].prdtNm);
		console.log(result.data.contents[0].qy);
		
		lineId.innerHTML = result.data.contents[0].lineId;
		prdtId.innerHTML = result.data.contents[0].prdtId;
		prdtNm.innerHTML = result.data.contents[0].prdtNm;
		qy.innerHTML = result.data.contents[0].qy;
		
	})
	
	btnPrint.addEventListener("click", function() {
		console.log(121212);
		window.print();
	})
</script>

</html>