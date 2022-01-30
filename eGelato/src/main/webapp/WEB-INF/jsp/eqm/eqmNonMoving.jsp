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
<body>
	<!-- 설비검색 모달 -->
	<div id="dialog-form" title="설비검색"></div>

	<div class="container">
		<div class="flex row">
			<div class="col-4">
				<br>
				<h2>설비목록</h2>
				<br> <label>설비구분</label> <select id="gubun"
					onchange="selectGubun()">
					<option value="선택">선택
					<option value="배합기">배합기
					<option value="운송기">운송기
					<option value="측정기">측정기
					<option value="가공기">가공기
				</select> 가동설비<input type="radio" name="eqmNonYn" value="Y"> 비가동설비<input
					type="radio" name="eqmNonYn" value="N"> 전체<input
					type="radio" name="eqmNonYn" value="" checked>
				<div id="eqmListGrid" style="width: 100%;"></div>
			</div>
			<div class="col-8">

				<div class="container">
					<h2>비가동 내역 조회</h2>
					<form id="dataForm" name="dataForm" method="post"
						autocomplete="off">
						<div>
							<ul>
								<li>
									<div class="col-8">
										<label>해당일자</label> <input id="fromDate" name="fromDate"
											type="date"><label>~</label><input id="toDate"
											name="toDate" type="date">
									</div>
								</li>
								<li>
									<div class="col-8">
										<label>설비코드</label> <input id="searchId" required>
										<button type="button" id="btnEqmSearch"
											class="btn cur-p btn-outline-dark btn-sm">🔍</button>
										<input id="searchNm" readonly>

									</div>
								</li>
							</ul>
							<div class="grid-option-area">
								<div class="col-6"></div>
								<div class="col-6">
									<button type="reset" class="btn btn-reset" id="resetBtn">초기화</button>
									<button type="button" class="btn btn-search" id="searchBtn">조회</button>
									<button type="button" class="btn btn-exel" id="excelBtn">Excel</button>
									<button type="button" class="btn btn-print" id="printBtn">인쇄</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="eqmNonList" style="width: 100%;"></div>
				<div id="eqmNonInsert" style="display: none;">
					<br>
					<h2>비가동 등록</h2>
					<br>
					<form
						action="${pageContext.request.contextPath}/eqm/eqmNonInsert.do"
						method="post" name="frm">
						<table>
							<tbody>
								<tr>
									<th>설비코드</th>
									<td><input name="eqmId" id="eqmId" readonly></td>
									<th>설비명</th>
									<td><input name="eqmName" id="eqmName" readonly></td>
								</tr>
								<tr>
									<th>등록자</th>
									<td><input></td>
								</tr>
								<tr>
									<th>비가동시간</th>
									<td><input name="workSttmH" id="workSttmH" type="time"></td>
									<td><button type="button" id="workStart">시작</button></td>
									<td><input name="workEntmH" id="workEntmH" type="time"></td>
									<td><button type="button" id="workStop" disabled>종료</button></td>
								</tr>
								<tr>
									<th>비가동사유</th>
									<td><select name="resnId" id="resnId">
											<option value="NOPR01">수리</option>
											<option value="NOPR02">점검</option>
											<option value="NOPR03">청소</option>
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
	<script>
	//등록 버튼 클릭시 얼럿창
	function msg(){
		alert("등록됨");
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
		bodyHeight : 500,
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
		},{
			header : '사용여부',
			name : 'useYn'
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
	
	//비가동등록 버튼 이벤트
	$("#insertEqmNon").on("click", function(){
		
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