<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비 점검 페이지(점검등록/점검내역조회)</title>
</head>
<body>
<!-- 설비검색 모달 -->
	<div id="dialog-form" title="설비검색"></div>
	
	<h2>설비 정기점검 관리</h2>
	<div class="container">
		<br> <br>
		<div class="row">
			<div class="col-12">
				<button type="reset" class="btn btn-reset float-right" id="resetBtn">초기화</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-search float-right"
					id="searchBtn">조회</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-exel float-right" id="saveBtn">저장</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-print float-right"
					id="removeBtn">삭제</button>
			</div>
		</div>
		<form id="dataForm" name="dataForm" method="post">
			<div class="grid-option-area row">
				<div class="col-6">
					<div>
						<label>점검일자</label><input type="date" id="chckDate">
					</div>
					<div>
						<label>특이사항</label> <input type="text" id="remk">
					</div>
					<div>
						<label>설비구분</label> <select id="gubun" onchange="selectGubun()">
							<option value="전체">전체
							<option value="배합기">배합기
							<option value="운송기">운송기
							<option value="측정기">측정기
							<option value="가공기">가공기
						</select>
					</div>
				</div>
				<div class="col-6 border" style="width: 500px;">
					<div>
						<ul>
							<li>
								<h5>설비 점검대상기간</h5>
							</li>
							<li>
								<div>
									<label>점검일자</label> <input id="fromCkDate" name="fromCkDate"
										type="date"><label>~</label><input id="toCkDate"
										name="toCkDate" type="date">
									<button class="btn btn-print float-right" id="eqmChck" type="button">설비조회</button>
								</div>
							<li>
						</ul>
					</div>
				</div>
			</div>
		</form>
		<div>
			<div id="eqmInsGrid"></div>
		</div>
	</div>
	<script>
		var d = new Date();
		var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
		document.getElementById('fromCkDate').value = nd.toISOString().slice(0, 10);
		document.getElementById('toCkDate').value = d.toISOString().slice(0, 10);
	
		var Grid = tui.Grid;

		const eqmInsGrid = new Grid({
			el : document.getElementById('eqmInsGrid'),
			data : {
				api : {
					readData : {url : '${path}/eqm/eqmInspectionList.do', method : 'GET'},
					modifyData :{ url: '${path}/eqm/chckModifyData.do', method:'PUT'}
				},
				contentType : 'application/json',
				initialRequest : false
			},
			rowHeaders : [ 'rowNum' ],
			selectionUnit : 'row',
			bodyHeight : 500,
			columns : [ {
				header : '설비코드',
				name : 'eqmId'
			}, {
				header : '설비명',
				name : 'eqmName'
			}, {
				header : '점검주기',
				name : 'chckPerd'
			}, {
				header : '점검일자',
				name : 'chckDt'
			}, {
				header : '차기점검일',
				name : 'nmCkDt'
			}, {
				header : '판정',
				name : 'judt',
				align: 'center',
			    editor: {
				type: GelatoSelectEditor,
	      		options: {
			        listItems: [
	        			{text : '합격', value :'합격'},
	        			{text : '수리', value :'수리필요'},
	        			{text : '교체', value :'교체필요'},
	        			{text : '정밀점검', value :'정밀점검필요'}
	        			]		
			      }
			    },
			    renderer: {
		            type: GelatoSelect
		      		} 
			}, {
				header : '점검내역',
				name : 'chckDeta',
				align: 'center',   
			    /* editor: {
				type: GelatoSelectEditor,
	      		options: {
			        listItems: [
	        			{text : '합격', value :'합격'},
	        			{text : '수리', value :'수리필요'},
	        			{text : '교체', value :'교체필요'},
	        			{text : '정밀점검', value :'정밀점검필요'}
	        			]		
			      }
			    },
			    renderer: {
		            type: GelatoSelect
		      		}  */
			}, {
				header : '검수인',
				name : 'inspr'
			} ]
		});

		//드롭다운 선택시 바로 조회
		function selectGubun() {
			let gubun = $('#gubun option:selected').val();
			eqmListGrid.readData(1, {'gubun' : gubun}, true);
		}

		//점검일자 input태그에 현재날짜 띄우기
		document.getElementById('chckDate').value = new Date().toISOString().substring(0, 10);
		
		//(점검일자별)설비조회 검색 모달
		let dialog = $("#dialog-form").dialog({
			autoOpen :false,
			modal : true,
			width : "700px"
		});
		
		$("#eqmChck").on("click", function(){
		
			dialog.dialog("open");
			$("#dialog-form").load("${path}/eqm/eqmCkModal.do",function(){
				console.log("설비검색 모달 로드됨")})
		});
		
		$("#resetBtn").on("click", function(){
			eqmInsGrid.clear();
		})
		
	</script>
</body>
</html>