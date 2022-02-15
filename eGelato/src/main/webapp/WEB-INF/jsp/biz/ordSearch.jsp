<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>주문서 조회</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<h2>주문서 관리 조회</h2>
	<div>
		<form>
			<table style="margin-bottom: 10px;">
				<tbody>
					<tr>
						<th>진행 구분</th>
						<td><input type="radio" name="stFgRadio" id="stFg"
							value="ACCEPT">접수 <input type="radio" name="stFgRadio"
							id="stFgR" value="OUTSTC">출고 <input type="radio"
							name="stFgRadio" id="stFgRi" value="전체" checked>전체</td>
					</tr>
					<tr>
						<th>거래처</th>
						<td>
							<input type="text" id="vendName" name="vendName">
							<button type="button" id="BtnVend" class="btn-modal"></button>
							<input type="text" id="vendId" name="vendId" readonly>
						</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td>
							<input type="text" id="prdtNm" name="prdtNm">
							<button type="button" id="BtnPrdt" class="btn-modal"></button>
							<input type="text" id="prdtId" name="prdtId" readonly>
						</td>
					</tr>
					<tr>
						<th>주문 일자</th>
						<td><input type="date" id="startDt"
							style="margin-right: 8px;"> ~ <input type="date"
							id="endDt" style="margin-left: 8px;"></td>
					</tr>
					<tr>
						<th>납기 일자</th>
						<td><input type="date" id="startedDt"
							style="margin-right: 8px;"> ~ <input type="date"
							id="endedDt" style="margin-left: 8px;"></td>
						<td><button type="button"
								class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
							<button type="reset" class="btn cur-p btn-outline-primary">초기화</button></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<hr>
	<br>

	<div id="ordGrid" style="width: 100%"></div>
	<div id="prdtListmodal" title="제품 목록"></div>
	<div id="vendListmodal" title="거래처 목록"></div>



	<script>
		let prdtDialog;

		let vendDialog;

		// 주문서 관리 조회페이지에서 현재 날짜 기본 설정.
		const d = new Date();

		const year = d.getFullYear(); // 년
		const month = d.getMonth(); // 월
		const day = d.getDate(); // 일

		document.getElementById('startDt').value = new Date(year, month,
				day - 5).toISOString().substring(0, 10);
		document.getElementById('endDt').value = new Date().toISOString()
				.substring(0, 10);

		document.getElementById('startedDt').value = new Date(year, month,
				day - 5).toISOString().substring(0, 10);
		document.getElementById('endedDt').value = new Date().toISOString()
				.substring(0, 10);

		var Grid = tui.Grid;

		//그리드 생성
		var ordGrid = new Grid({
			el : document.getElementById('ordGrid'),
			data : {
				api : {
					readData : {
						url : '${path}/biz/findOrderList.do',
						method : 'GET'
					},
				},
				contentType : 'application/json',
				initialRequest : false
			},
			rowHeaders : [ 'rowNum' ],
			selectionUnit : 'row',
			bodyHeight : 490,
			columns : [ {
				header : '주문코드',
				name : 'orderId',
				align : 'center'

			}, {
				header : '업체명',
				name : 'vendName',
				align : 'center'

			}, {
				header : '주문일자',
				name : 'orderDt',
				align : 'center'

			}, {
				header : '납기일자',
				name : 'oustDt',
				align : 'center'

			}, {
				header : '진행상황구분',
				name : 'stFg',
				align : 'center'

			},

			{
				header : '제품코드',
				name : 'prdtId',
				align : 'center'

			}, {
				header : '제품명',
				name : 'prdtNm',
				align : 'center'

			}, {
				header : '수량',
				name : 'qy',
				align : 'center'

			}, {
				header : '비고',
				name : 'remk',
				align : 'center'
			} ]
		});

		// 조회 버튼. // 해당날짜 조회 // 거래처 조회 // 제품코드 조회// 진행구분 라디오로 조회 =>  mapper-xml에서 if로 조건으로 나눔.
		$("#btnFind").on("click", function choicDate() {
			var startDt = document.getElementById("startDt").value;
			var endDt = document.getElementById("endDt").value;

			var startedDt = document.getElementById("startedDt").value;
			var endedDt = document.getElementById("endedDt").value;

			var vendName = document.getElementById("vendName").value;
			var prdtNm = document.getElementById("prdtNm").value;

			var stFg = $('input[name="stFgRadio"]:checked').val();

			console.log(startDt);
			console.log(endDt);
			console.log(startedDt);
			console.log(endedDt);
			console.log(vendName);
			console.log(prdtNm);
			console.log(stFg);

			ordGrid.readData(1, {
				'startDt' : startDt,
				'endDt' : endDt,
				'startedDt' : startedDt,
				'endedDt' : endedDt,
				'vendName' : vendName,
				'prdtNm' : prdtNm,
				'stFg' : stFg
			}, true);

		});

		// 모달창 생성 함수. 거래처
		$(function() {
			vendDialog = $("#vendListmodal").dialog({
				autoOpen : false,
				height : 600,
				width : 700,
				modal : true

			})
		});

		// 모달창 생성 함수. 제품
		$(function() {
			prdtDialog = $("#prdtListmodal").dialog({
				autoOpen : false,
				height : 600,
				width : 600,
				modal : true
			})
		});

		// 거래처 찾아보기 버튼 
		BtnVend.addEventListener("click", function() {

			console.log("모달클릭")
			vendDialog.dialog("open");

			// 컨트롤러에 보내주고 따로 모달은 jsp 만들 필요가 없으니깐  
			$('#vendListmodal').load("${path}/biz/vendModal.do", function() {
				console.log('로드됨')
				vendListGrid.readData(1, {}, true);
			})

		})

		// 제품코드 찾아보기 버튼
		BtnPrdt.addEventListener("click", function() {

			console.log("버튼클릭");
			prdtDialog.dialog("open");

			$("#prdtListmodal").load("${path}/biz/prdtModal.do", function() {
				console.log("제품코드 modal");
				prdtListGrid.readData(1, {}, true);
			})
		})

		//  거래처 인풋 태그에 값들어가게 함.	
		function getModalData(vendParam) {
			console.log(vendParam);
			$("#vendName").val(vendParam.vendName);
			$("#vendId").val(vendParam.vendId);
			vendDialog.dialog("close");
		}
		// 제품코드 인풋 태그에 값들어가게 함.
		function getModal(prdtParam) {
			console.log(prdtParam);
			$("#prdtNm").val(prdtParam.prdtNm);
			$("#prdtId").val(prdtParam.prdtId);
			prdtDialog.dialog("close");
		}
	</script>

</body>
</html>