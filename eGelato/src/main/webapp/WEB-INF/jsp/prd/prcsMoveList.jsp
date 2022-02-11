<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
th, td {
padding: 5px;
}
</style>
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
	
	<div align="center">
		<table>
		<tbody>
			<tr>
				<td colspan="4">
					<div id="bcTarget" ></div> 
				</td>	
			</tr>
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
	<br>
	<div align="center">
		<table id='prcsInfo' border="1" style="border-collapse : collapse" >
		<tbody>
			<tr>
				<th>진행공정코드</th>
				<th>공정코드</th>
				<th>공정명</th>
				<th>설비코드</th>
				<th>설비명</th>
				<th>담당자</th>
				<th>투입량</th>
				<th>불량량</th>
				<th>생산량</th>
			</tr>
		</tbody>
		</table>
	</div>
	<br>
	<div align="center">
		<button type="button" class="btn btn-secondary" id="btnPrint">인쇄</button>
	</div>
</body>

<script>
	//onclick="window.print()"
	let mid = '${param.mid}';
	console.log(mid);
	
	// 공정이동표 컨트롤러 line에다가 만들어놓음. 왜 그런지는 모르겠지만 거기있음. 자다가 그랬나봐요... 혹시 볼 사람 있다면 거기를 보세요...ㅠ
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
		
		lineId.innerHTML = result.data.contents[0].lineId;
		prdtId.innerHTML = result.data.contents[0].prdtId;
		prdtNm.innerHTML = result.data.contents[0].prdtNm;
		qy.innerHTML = result.data.contents[0].qy;
		
		$.ajax({
			url : "${path}/prd/prdtPrcsMoveInfo.do?indicaDetaId="+mid,
			dataType : 'json',
			error : function(result2) {
				console.log('에러', result2)
			}		
		}). done(function(result2) {
			console.log(result2);
			console.log(result2.data.contents.length);
			
			for ( j=0 ; j<result2.data.contents.length ; j++) {
				
				$("#prcsInfo>tbody").append("<tr id="+j+"><td>"+result2.data.contents[j].prcsNowId+"</td></tr>");
				
				$("#" + j).append("<td>" + result2.data.contents[j].prcsId + "</td>");
				$("#" + j).append("<td>" + result2.data.contents[j].nm + "</td>");
				$("#" + j).append("<td>" + result2.data.contents[j].eqmId + "</td>");
				$("#" + j).append("<td>" + result2.data.contents[j].eqmName + "</td>");
				$("#" + j).append("<td>" + result2.data.contents[j].mngr + "</td>");
				$("#" + j).append("<td>" + result2.data.contents[j].inptQyT + "</td>");
				$("#" + j).append("<td>" + result2.data.contents[j].inferQyT + "</td>");
				$("#" + j).append("<td>" + result2.data.contents[j].prodQyT + "</td>");
			}
			
			/* console.log(result2.data.contents.length);
			qy.innerHTML = result2.data.contents[result2.data.contents.length-1].prodQyT; */
		})
	})
	
	btnPrint.addEventListener("click", function() {
		console.log(121212);
		window.print();
	})
</script>

</html>