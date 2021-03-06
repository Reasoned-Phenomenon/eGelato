<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비비가동 페이지(비가동등록/비가동내역 조회)</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<!-- 설비검색 모달 -->
	<div id="dialog-form" title="설비검색"></div>

	<div class="container col-sm-12" style="margin: 0px; width: 100%;">
		<div class="flex row">
			<div class="col-5">
				<h2>설비목록</h2>
				<table style="margin-bottom:15px;">
					<tbody>
						<tr>
							<th>설비구분</th>
							<td><select id="gubun" onchange="selectGubun()">
									<option value="선택">선택
									<option value="배합기">배합기
									<option value="운송기">운송기
									<option value="측정기">측정기
									<option value="가공기">가공기
							</select></td>
							<td>전체<input type="radio" name="eqmNonYn" value="" checked>
								가동설비<input type="radio" name="eqmNonYn" value="Y"> 비가동설비<input
								type="radio" name="eqmNonYn" value="N">
							</td>
						</tr>
					</tbody>
				</table>
				<div id="eqmListGrid" style="width: 100%;"></div>
			</div>
			<div class="col-7">
				<div>
					<h2>비가동 내역 조회</h2>
					<form id="dataForm" name="dataForm" method="post">
						<table>
							<tbody>
								<tr>
									<th>해당일자</th>
									<td><input id="fromDate" name="fromDate" type="date"
										style="margin-right: 11px;"><label>~</label><input
										id="toDate" name="toDate" type="date"
										style="margin-left: 11px;"></td>
								</tr>
								<tr>
									<th>설비코드</th>
									<td><input id="searchId" type="text" required>
										<button type="button" id="btnEqmSearch" class="btn-modal"
											style="margin-left: 0px;">🔍</button> <input id="searchNm"
										type="text" readonly></td>
									<td><button type="reset" class="btn" id="resetBtn">초기화</button>
										<button type="button" class="btn" id="searchBtn">조회</button></td>
								</tr>
							</tbody>
						</table>
					</form>
					<div id="eqmNonList" style="width: 100%;"></div>
					<div id="eqmNonInsert" style="display: none;">
						<h2>비가동 등록</h2>
						<form
							action="${pageContext.request.contextPath}/eqm/eqmNonInsert.do"
							method="post" name="frm">
							<table class="table table-bbs" style="width: 100%;">
								<tbody>
									<tr>
										<th>설비코드</th>
										<td><input name="eqmId" id="eqmId" type="text" readonly></td>
										<th>설비명</th>
										<td><input name="eqmName" id="eqmName" type="text"
											readonly></td>
									</tr>
									<tr>
										<th>등록자</th>
										<td><input value="${loginVO.name }" type="text"></td>
									</tr>
									<tr>
										<th>비가동시간</th>
										<td><input name="workSttmH" id="workSttmH" type="time">
											<button type="button" id="workStart" style="float: right;">시작</button></td>

										<td><input name="workEntmH" id="workEntmH" type="time"></td>
										<td><button type="button" id="workStop" disabled>종료</button></td>
									</tr>
									<tr>
										<th>비가동사유</th>
										<td><select name="resnId" id="resnId">
												<option value="EQMR-001">수리</option>
												<option value="EQMR-002">점검</option>
												<option value="EQMR-003">청소</option>
										</select></td>
										<th>비고</th>
										<td><input type="text" name="remk"></td>
									</tr>
									<tr>
										<td><button id="insertEqmNon" onclick="msg()">비가동등록</button></td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	//토스트옵션
	toastr.options = {
			positionClass : "toast-top-center",
			progressBar : true,
			timeOut: 1500 // null 입력시 무제한.
		}
	
	//인풋태그(우측) 일주일 단위로 설정하기
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('fromDate').value = nd.toISOString().slice(0,
			10);
	document.getElementById('toDate').value = d.toISOString()
			.slice(0, 10);
	
	//등록 버튼 클릭시 얼럿창
	function msg(){
		alert("비가동 등록되었습니다");
	}
	
	//설비비가동내역 전체조회 버튼
	$("#searchAllBtn").on("click",function(){
		eqmNonListGrid.readData(1,{}, true);
	})
	
	//설비 가동/비가동 라디오 버튼 
	$("input[name='eqmNonYn']:radio").change(function () {
        //라디오 버튼 값을 가져온다.
        var eqmNonYn = this.value;
        console.log(eqmNonYn);
	});
	
	// 화면 시작시 설비 전체리스트 바로 띄우기
	$(function(){
		var eqmNonYn=$("input[name='eqmNonYn']:radio").val();
		 eqmListGrid.readData(1,{'useYn' : eqmNonYn,'gubun':$("#gubun").val()}, true);
	})
	
	//라디오 버튼 클릭시 바로 조회
	$("input[name='eqmNonYn']:radio").change(function () {
        //라디오 버튼 값을 가져온다.
        console.log(this);
        var eqmNonYn = this.value;   
        console.log($("#gubun").val());
        eqmListGrid.readData(1,{'eqmNonYn' : eqmNonYn, 'gubun':$("#gubun").val()}, true);
	});
	
	//드롭다운 선택시 바로 조회
	function selectGubun(){
		var gubun = $('#gubun option:selected').val();
		var eqmNonYn=$("input[name='eqmNonYn']:radio:checked").val();
	console.log("!!!!!!"+eqmNonYn);
		eqmListGrid.readData(1, {
			'eqmNonYn' : eqmNonYn,
			'gubun' : gubun
		}, true);
	}
	
	//설비관리 페이지에서 넘어오는 값이 있을 때 비가동등록 창 띄우기
	if("${datas.eqmId}"==""){
		
	}else{
		$("#eqmNonInsert").css("display","block");
		$("#eqmId").val("${datas.eqmId}");
		$("#eqmName").val("${datas.eqmName}");
	}
	
	var Grid = tui.Grid;
	
	//설비리스트 - 좌측 그리드
	const eqmListGrid = new Grid({
		el : document.getElementById('eqmListGrid'),
		data : {
			api : {
				readData : {
					url : '${path}/eqm/eqmNonMovingList.do',
					method : 'GET'
				}
			},
			contentType : 'application/json'
		},
		bodyHeight : 600,
		columns : [ {
			header : '설비코드',
			name : 'eqmId'
		}, {
			header : '설비명',
			name : 'eqmName',
			width : 'auto'
		}, {
			header : '공정명',
			name : 'nm',
			width : 'auto'
		}, {
			header : '점검주기',
			name : 'chckPerd',
			align: 'right'
		},{
			header : '사용여부',
			name : 'useYn',
			align: 'center'
		},
		]
	});
	
	//좌측 그리드에서 한 행 선택시 비가동 등록 창 띄우기(비가동설비 체크시 등록 창 안띄움)
	eqmListGrid.on("dblclick", (ev) => {
		 var abc = eqmListGrid.getValue(ev["rowKey"],"useYn");
		if(abc==('Y')){
		$("#eqmNonInsert").css("display","block");
		$("#eqmId").val(eqmListGrid.getValue(ev["rowKey"],"eqmId"));
		$("#eqmName").val(eqmListGrid.getValue(ev["rowKey"],"eqmName"));
		}else{
			$("#eqmNonInsert").css("display","none");
			toastr.clear()
			toastr.warning( ('비가동 설비입니다.'),'Gelato',{timeOut:'1500'} );
			return;
		}
	}) 
	
	//비가동내역조회 그리드
	const eqmNonListGrid = new Grid({
		el : document.getElementById('eqmNonList'),
		data : {
			api : {
				readData : {
					url : '${path}/eqm/eqmNonSelect.do',
					method : 'GET'
				}
			},
			initialRequest : false,
			contentType : 'application/json'
		},
		rowHeaders : [ 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight : 200,
		columns : [ {
			header : '설비코드',
			name : 'eqmId'
		}, {
			header : '설비명',
			name : 'eqmName'
		}, {
			header : '비가동명',
			name : 'resnName'
		}, {
			header : '시작시간',
			name : 'nonOprFrTm',
		}, {
			header : '종료시간',
			name : 'nonOprToTm',
		} ]
	});
	
	//비가동시작시간 버튼 이벤트
	$("#workStart").on("click",function(){
		let date1 = new Date();
		workSttmH.value = ("00"+date1.getHours()).slice(-2)+":"+("00"+date1.getMinutes()).slice(-2);			
		console.log(workSttmH.value)
		$("#workStop").removeAttr("disabled");
	})
	
	//비가동종료시간 버튼 이벤트
	$("#workStop").on("click",function(){
		let date2 = new Date();
		workEntmH.value = ("00"+date2.getHours()).slice(-2)+":"+("00"+date2.getMinutes()).slice(-2);			
		console.log(workEntmH.value)
		$("#workStop").attr("disabled",true);
	})
	
	//설비코드 모달
		let dialog = $( "#dialog-form" ).dialog({
			autoOpen :false,
			modal : true
		});
		
		$("#btnEqmSearch").on("click",function(){
			dialog.dialog("open");
			$("#dialog-form").load("${path}/eqm/searchEqmModal.do", 	
					function(){
				console.log("설비모달로드됨")})
		});
		
	//비가동사유코드 검색 모달
		let dialogSearch = $("#dialog-search").dialog({
			autoOpen :false,
			modal : true
		});
	
		$("#btnEqmNonResnSearch").on("click", function(){
			dialogSearch.dialog("open");
			$("#dialog-search").load("${path}/eqm/eqmNonResnModal.do", 	
					function(){
				console.log("비가동사유코드 검색모달 로드됨")})
		})
	
	//해당일자 검색
	var toDate;
	var fromDate;
	var searchId;
	$("#searchBtn").on("click",function(){
		toDate = document.getElementById("toDate").value;
		fromDate = document.getElementById("fromDate").value;
		searchId = document.getElementById("searchId").value;
		console.log(toDate);
		console.log(fromDate);
		console.log(searchId);
		if(searchId == ''){
			alert("설비코드를 선택해주세요");
			return; 
		}
		if(toDate < fromDate){
			alert("날짜가 검색조건에 부합하지 않습니다.");
			document.getElementById("toDate").value = null;
			document.getElementById("fromDate").value = null;
			return;
		}
		eqmNonListGrid.readData(1,{'toDate': toDate, 'fromDate': fromDate,  'eqmId': searchId}, true);
	})
		
	</script>
</body>
</html>