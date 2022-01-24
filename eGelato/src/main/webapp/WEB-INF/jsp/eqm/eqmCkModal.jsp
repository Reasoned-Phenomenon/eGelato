<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비 점검대상 모달</title>
</head>
<body>
	<div id="eqmCkGrid"></div>
	<div>
		<button id="btnOk" class="btn btn-print">확인</button>
		<button id="btnCn" class="btn btn-print">취소</button>
	</div>
	<script>

		var fromCkDate = $("#fromCkDate").val();
		var toCkDate = $("#toCkDate").val();
		
		
		var params = {
		'fromCkDate' : fromCkDate,
		'toCkDate' : toCkDate
		}
		console.log(params)
		var Grid = tui.Grid;
		
		var eqmCkGrid = new Grid({
			el : document.getElementById('eqmCkGrid'),
			data : {
				api : {
					readData : {
						url : '${path}/eqm/eqmCkDate.do',
						method : 'GET',
						initParams : params
					},
				},
				contentType : 'application/json'
			},
			rowHeaders : [ 'checkbox', 'rowNum' ],
			selectionUnit : 'row',
			bodyHeight : 300,
			columns : [ {
				header : '설비코드',
				name : 'eqmId'
			}, {
				header : '설비명',
				name : 'eqmName'
			}, {
				header : '점검일자', 
				name : 'chckDt'
			}, {
				header : '차기점검일자',
				name : 'nmCkDt'
			}, {
				header : '점검주기',
				name : 'chckPerd'
			}, {
				header : '판정',
				name : 'judt',
				hidden : true
			}, {
				header : '점검내역',
				name : 'chckDeta',
				hidden : true
			}, {
				header : '검수인',
				name : 'inspr',
				hidden : true
			}  ]
		});
		
		//모달창에서 확인 클릭시 그리드에 선택한 것만 띄우기
		$("#btnOk").on("click", function(){
			checked = eqmCkGrid.getCheckedRows();
			for(let vo of checked){
				
				eqmInsGrid.appendRow({});
				
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'eqmId', vo.eqmId);
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'eqmName', vo.eqmName);
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'chckPerd', vo.chckPerd);
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'chckDt', vo.chckDt);
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'nmCkDt', vo.nmCkDt);
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'judt', vo.judt);
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'chckDeta', vo.chckDeta);
				eqmInsGrid.setValue(eqmInsGrid.getRowCount()-1, 'inspr', vo.inspr);
			}
			
			dialog.dialog("close");
		})

		
	</script>
</body>
</html>