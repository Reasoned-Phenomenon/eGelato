<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비 점검 페이지(점검등록/점검내역조회)</title>
<style>
.tui-grid-btn-filter {
	display: none
}
</style>
</head>
<body class="desktop">
	<!-- 설비검색 모달 -->
	<div id="dialog-form" title="설비검색"></div>
	<!-- 해당일자 점검내역 모달 -->
	<div id="chckDialog-form" title="일 점검자료 관리"></div>
	<div class="container">
		<div class="row">
			<br> 
			<br>
			<h2 class="title">설비 정기점검 관리</h2>
			<div class="col-12">
				<button type="reset" class="btn btn-reset float-right" id="resetBtn">초기화</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-search float-right"
					id="searchBtn">조회</button>
				<button type="button" class="btn btn-search float-right"
					id="searchAllBtn">전체조회</button>
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
						<label>설비구분</label> <select id="gubun" onchange="selectGubun()">
							<option value="전체">전체
							<option value="배합기">배합기
							<option value="운송기">운송기
							<option value="측정기">측정기
							<option value="가공기">가공기
						</select>
					</div>
				</div>
				<div class="col-6 border">
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
									<button class="btn btn-print float-right" id="eqmChck"
										type="button">설비조회</button>
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
		//인풋태그(우측) 일주일 단위로 설정하기
		var d = new Date();
		var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
		document.getElementById('fromCkDate').value = nd.toISOString().slice(0,
				10);
		document.getElementById('toCkDate').value = d.toISOString()
				.slice(0, 10);

		var Grid = tui.Grid;

		const eqmInsGrid = new Grid({
			el : document.getElementById('eqmInsGrid'),
			data : {
				api : {
					readData : {
						url : '${path}/eqm/eqmInspectionList.do',
						method : 'GET'
					},
					modifyData : {
						url : '${path}/eqm/chckModifyData.do',
						method : 'PUT'
					}
				},
				contentType : 'application/json',
				initialRequest : false
			},
			rowHeaders : [ 'checkbox', 'rowNum' ],
			selectionUnit : 'row',
			bodyHeight : 500,
			columns : [ {
				header : '설비코드',
				name : 'eqmId'
			}, {
				header : '설비명',
				name : 'eqmName'
			}, {
				header : '설비구분',
				name : 'fg',
				filter : {
					type : 'text',
					showApplyBtn : true,
					showClearBtn : true
				}
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
				align : 'center',
				editor : {
					type : GelatoSelectEditor,
					options : {
						listItems : [ {
							text : '합격',
							value : 'Test01'
						}, {
							text : '수리',
							value : 'Test02'
						}, {
							text : '교체',
							value : 'Test03'
						}, {
							text : '정밀점검',
							value : 'Test04'
						} ]
					}
				},
				renderer : {
					type : GelatoSelect
				}
			}, {
				header : '점검내역',
				name : 'chckDeta',
				align : 'center',
				editor : 'text'
			}, {
				header : '검수인',
				name : 'inspr'
			} ]
		});

		var abc = '';
		//드롭다운 선택시 바로 조회
		function selectGubun() {
			var gubun = $('#gubun option:selected').val();
			//eqmInsGrid.readData(1, {'gubun' : gubun, 'chckDt' : abc}, true);
			if (gubun == '전체') {
				eqmInsGrid.unfilter('fg');
			} else {
				eqmInsGrid.filter('fg', [ {
					code : 'eq',
					value : gubun
				} ]);
			}
		}

		//점검일자 input태그에 현재날짜 띄우기
		document.getElementById('chckDate').value = new Date().toISOString()
				.substring(0, 10);

		//(점검일자별)설비조회 검색 모달(우측)
		let dialog = $("#dialog-form").dialog({
			autoOpen : false,
			modal : true,
			width : "700px"
		});

		//(점검일자별) 설비점검내역 조회 모달
		let ckDialog = $("#chckDialog-form").dialog({
			autoOpen : false,
			modal : true,
			width : "700px"
		})

		//모달창 
		$("#eqmChck").on("click", function() {

			dialog.dialog("open");
			$("#dialog-form").load("${path}/eqm/eqmCkModal.do", function() {
				console.log("설비검색 모달 로드됨")
			})
		});

		//저장버튼
		$("#saveBtn").on("click", function() {
			eqmInsGrid.request('modifyData');
		})

		//삭제버튼
		$("#removeBtn").on("click", function() {
			eqmInsGrid.request('modifyData', {
				'checkedOnly' : true,
				'modifiedOnly' : false,
				'showConfirm' : false
			});
			eqmInsGrid.removeCheckedRows(true)
		})

		//초기화버튼
		$("#resetBtn").on("click", function() {
			eqmInsGrid.clear();
		})

		//전체조회버튼
		$("#searchAllBtn").on("click", function() {
			eqmInsGrid.readData(1, {
				'gubun' : '전체',
				'chckAll' : 'Y'
			}, true);
		})

		//조회버튼
		$("#searchBtn").on(
				"click",
				function() {
					ckDialog.dialog("open");
					$("#chckDialog-form").load("${path}/eqm/eqmDayCkModal.do",
							function() {
								console.log("일 관리점검 모달 로드됨");
							})
				})
	</script>
</body>
</html>