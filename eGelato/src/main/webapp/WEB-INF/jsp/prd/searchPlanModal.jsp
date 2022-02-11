<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색결과 조회 modal</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>생산 계획</h1>
	<br><br>
	<div>
	<h4> 기간으로 조회 </h4> 
	<input type="date" id="startD"> ~ <input type="date" id="endD">
	<button type="button" id="selectDate" class="btn btn-find-small" data-bs-toggle="modal" aria-label="Close">검색</button>
	</div>
	<br>
	<div id="searchPlanGrid"></div>
	
<script>

//기간 검색
var startD;
var endD;
    
$("#selectDate").on(
		"click", function chooseDate() {
			startD = document.getElementById("startD").value;
			endD = document.getElementById("endD").value;
			console.log(startD);
			console.log(endD);
			
			searchPlanGrid.readData(1,{'startD':startD, 'endD':endD}, true);
		});

// 그리드 생성
	var Grid = tui.Grid;
	
	//그리드 테마
	/* Grid.applyTheme('striped', {
		  cell: {
		    header: {
		      background: '#eef'
		    },
		    evenRow: {
		      background: '#fee'
		    },
			selectedHeader : {
		    	background : '#FFFFFF'
		    }
		  }
		}); */
		
	// 그리드 생성
	var searchPlanGrid = new Grid({
		el: document.getElementById('searchPlanGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/prd/searchPlanList.do', method: 'GET'}
		  },
		  contentType: 'application/json',
		},
	  	rowHeaders:['rowNum'],
	  	bodyHeight: 330,
	  	selectionUnit: 'row',
	  	columns:[
	  		  {
			    header: '계획코드',
			    name: 'planId'
			  },
			  {
			    header: '계획명',
			    name: 'name',
			  },
			  {
			    header: '계획일자',
			    name: 'dt'
			  }
			],
			 rowHeaders: ['rowNum'],
		/* pageOptions: {
		  useClient: true,
		  perPage: 10
		} */
	});

// 그리드 이벤트
// 클릭 이벤트

searchPlanGrid.on("dblclick", (ev) => {
	
	searchPlanGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, searchPlanGrid.getColumns().length-1]
	});
	
	var spg = searchPlanGrid.getRow(ev.rowKey).planId;
	var spn = searchPlanGrid.getRow(ev.rowKey).name;
	console.log(spg + ',' + spn);
	choosePI(spg , spn);
	
});




</script>
</body>
</html>