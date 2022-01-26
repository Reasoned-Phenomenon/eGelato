<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일 점검자료 조회 모달</title>
</head>
<body>
	<div>
		<h2>일 점검자료 관리</h2>
	</div>
	<div>
		<div>
			<form id="searchForm" name="searchForm" method="get">
				<div>
					<label>점검일자</label> <input id="fromDayCkDate" name="fromDayCkDate"
						type="date"><label>~</label><input id="toDayCkDate"
						name="toDayCkDate" type="date">
					<button class="btn btn-print float-right" id="eqmDayChck"
						type="button">설비조회</button>
				</div>
			</form>
			<div id="eqmDayCkGrid"></div>
		</div>
	</div>
	<script>
		
		//인풋태그 일주일 단위로 설정하기
		var d = new Date();
		var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
		document.getElementById('fromDayCkDate').value = nd.toISOString().slice(0, 10);
		document.getElementById('toDayCkDate').value = d.toISOString().slice(0, 10);
	
		var fromDayCkDate = $("#fromDayCkDate").val();
		var toDayCkDate = $("#toDayCkDate").val();
		
		
		var params = {
		'fromDayCkDate' : fromDayCkDate,
		'toDayCkDate' : toDayCkDate
		}
		
		console.log(params)
		
		var Grid = tui.Grid;
		
		var eqmDayCkGrid = new Grid({
			el : document.getElementById('eqmDayCkGrid'),
			data : {
				api : {
					readData : {
						url : '${path}/eqm/eqmDayCkGrid.do',
						method : 'GET',
						initParams : params
					},
				},
				contentType : 'application/json'
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			bodyHeight : 300,
			columns : [ {
				header : '점검일자',
				name : 'chckDt'
			}, {
				header : '건수', 
				name : 'total'
			}]
		});
		
		//설비조회 버튼
		var toDayCkDate;
		var fromDayCkDate;
		$("#eqmDayChck").on("click",function(){
			toDayCkDate = document.getElementById("toDayCkDate").value;
			fromDayCkDate = document.getElementById("fromDayCkDate").value;
			console.log(toDayCkDate);
			console.log(fromDayCkDate);
			if(toDayCkDate < fromDayCkDate){
				alert("날짜가 검색조건에 부합하지 않습니다.");
				document.getElementById("toDayCkDate").value = null;
				document.getElementById("fromDayCkDate").value = null;
				return;
			}
			eqmDayCkGrid.readData(1,{'toDayCkDate': toDayCkDate, 'fromDayCkDate': fromDayCkDate}, true);
		})
		
		//점검일자 선택 이벤트
		eqmDayCkGrid.on('dblclick', (ev) => {	
				
				//cell 선택시 row 선택됨.
				eqmDayCkGrid.setSelectionRange({
				      start: [ev.rowKey, 0],
				      end: [ev.rowKey, eqmDayCkGrid.getColumns().length-1]
				  });
				
				//클릭한 row에 해당하는 점검일자를 읽어옴
				codeParam = eqmDayCkGrid.getValue(ev.rowKey, 'chckDt');
				console.log("codeParam"+codeParam)
				
				var gubun = $('#gubun option:selected').val(); 
				
				eqmInsGrid.readData(1,{'chckDt': codeParam, 'gubun': gubun}, true);
				abc = codeParam;
				ckDialog.dialog("close");
			});
		
		
		
	</script>
</body>
</html>