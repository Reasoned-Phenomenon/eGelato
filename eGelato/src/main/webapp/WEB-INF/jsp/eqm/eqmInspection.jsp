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
th, td {
	padding: 5px;
}
</style>
</head>
<body>
	<!-- 설비검색 모달 -->
	<div id="dialog-form" title="설비검색"></div>
	
	<!-- 해당일자 점검내역 모달 -->
	<div id="chckDialog-form" title="일 점검자료 관리"></div>

	<h2>설비 정기점검 관리</h2>
	<form id="dataForm" name="dataForm" method="post">
		<table>
			<tbody>
				<tr>
					<th>설비구분</th>
					<td><select id="gubun" onchange="selectGubun()">
							<option value="전체">전체
							<option value="배합기">배합기
							<option value="운송기">운송기
							<option value="측정기">측정기
							<option value="가공기">가공기
					</select></td>
				</tr>
				<tr>
					<th>점검일자</th>
					<td><input id="fromCkDate" name="fromCkDate" type="date"
						style="margin-right: 8px;">~<input id="toCkDate"
						name="toCkDate" type="date" style="margin-left: 8px;">
						<button class="btn" id="eqmChck" type="button">설비조회</button></td>
				</tr>
			</tbody>
		</table>
	</form>
	
	<div style="float: right; margin-bottom: 10px; margin-top: 25px;">
		<button type="reset" id="resetBtn" class="btn">초기화</button>
		<button type="button" id="searchBtn" class="btn">조회</button>
		<button type="button" id="searchAllBtn" class="btn">전체조회</button>
		<button type="button" id="saveBtn" class="btn">저장</button>
		<button type="button" id="removeBtn" class="btn">삭제</button>
	</div>
	
	<hr>
	<br>

	<div>
		<div id="eqmInsGrid"></div>
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
							value : 'TEST01'
						}, {
							text : '수리',
							value : 'TEST02'
						}, {
							text : '교체',
							value : 'TEST03'
						}, {
							text : '정밀점검',
							value : 'TEST04'
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
		/* document.getElementById('chckDate').value = new Date().toISOString()
				.substring(0, 10); */

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
			if (eqmInsGrid.getRow(0) != null) {
				eqmInsGrid.blur();
			if(confirm("저장하시겠습니까?")){
			eqmInsGrid.request('modifyData', {
				showConfirm : false
			});			
			flag = 'O';
			toastr.clear()
			toastr.success( ('저장되었습니다.'),'Gelato',{timeOut:'1000'} );
			}
			}else {
				toastr.clear()
				toastr.warning( ('저장할 데이터가 없습니다.'),'Gelato',{timeOut:'1000'} );
			}
		});

		//삭제버튼
		$("#removeBtn").on("click", function() {
			if(confirm("선택하신 항목을 삭제하시겠습니까?")){ 
				eqmInsGrid.removeCheckedRows(false)
				eqmInsGrid.request('modifyData', {
					'checkedOnly' : true,
					'modifiedOnly' : false,
					'showConfirm' : false
				});
				toastr.clear()
				toastr.success( ('삭제되었습니다.'),'Gelato',{timeOut:'1000'} );
			}
			
			eqmInsGrid.removeCheckedRows(true)
		})

		//초기화버튼
		$("#resetBtn").on("click", function() {
			eqmInsGrid.clear();
		})

		//전체조회버튼
		$("#searchAllBtn").on("click", function() {
			console.log("!11111111111111111111")
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
		
	let evFlag = 'o';
	
	eqmInsGrid.on('click',function (ev) {
		
		if(evFlag == 'o' && ev.columnName =='judt') {
			eqmInsGrid.startEditing(ev.rowKey, 'judt', false)
			evFlag = 'x'
		}
		
	})	
	
	eqmInsGrid.on('editingFinish',function (ev) { 
		evFlag = 'o'
	})
	
		
	</script>
</body>
</html>