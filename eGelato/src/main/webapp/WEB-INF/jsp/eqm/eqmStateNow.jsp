<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>실시간 설비 상태(온도/UPH/생산량)</title>

</head>
<body>

<br>
<h2>모니터링 관리</h2>
<br>


<div class="col-4">
	<div id="chart-temp"></div>
</div>
<div class="col-4">
	<div id="chart-prod"></div>
</div>
<div class="col-4">
	<div id="eqmStateGrid" ></div>
</div>

<script>
//선언
let tempFlag;
let prodFlag;

//
let targetEqmId;

var Grid = tui.Grid;

//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	    },
	  }
});


let dataSources = {
	api: {
		readData:{ url: '${path}/eqm/findNowEqm.do', method: 'GET'},
	},
	contentType: 'application/json'
};
			
var eqmStateGrid = new Grid({
	el: document.getElementById('eqmStateGrid'),
	data : dataSources,
	rowHeaders:['rowNum'],
	selectionUnit: 'row',
	bodyHeight:600,
	columns:[
			{
			  header: '지시 상세 코드',
			  name: 'indicaDetaId'
			},
			{
			  header: '진행 공정 코드',
			  name: 'prcsNowId'
			},
			{
			  header: '공정 코드',
			  name: 'prcsId'
			},
			{
			  header: '설비 코드',
			  name: 'eqmId',
			  hidden: true
			}
		]
});

eqmStateGrid.on('click', (ev) => {	
	//console.log(ev)
	//cell 선택시 row 선택됨.
	eqmStateGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, eqmStateGrid.getColumns().length-1]
	  });

	targetEqmId = eqmStateGrid.getRow(ev.rowKey).eqmId;
	console.log(targetEqmId);
	chartAjax();
	//토스트
	toastr.clear();
	toastr.info(targetEqmId+' 선택','Gelato');
	
});


//--------------------------------------온도 차트 시작-------------------------------------------------------//
//온도 차트 생성
var tempEl = document.getElementById('chart-temp');

var tempData = {
	categories: [],
	series: [],
};

var tempOptions = { 
		chart: { title: '실시간 설비 온도', width: 400, height: 300 },
		xAxis: {
			title: '시간'
		},
		yAxis: {
			title: '온도',
		},
		tooltip: {
			formatter: (value) =>  value+`°C`,
		},
		legend: {
			align: 'bottom',
		},
        series: {
            spline: true,
        },
	};


var tempChart = toastui.Chart.lineChart({ el:tempEl, data:tempData, options:tempOptions });

//--------------------------------------온도 차트 끝-------------------------------------------------------//

//--------------------------------------생산량 차트 시작-------------------------------------------------------//
var prodEl = document.getElementById('chart-prod');

var prodData = {
	categories: [],
	series: [],
};

var prodOptions = {
  chart: { title: '실시간 설비 생산량', width: 400, height: 300 },
  xAxis: {
    title: '시간',
  },
  yAxis: {
    title: '생산량',
  },
  tooltip: {
	  formatter: (value) =>  value+`개`,
  },
  legend: {
    align: 'bottom',
  },
  series: {
      spline: true,
  },
};	

var prodChart = toastui.Chart.lineChart({ el:prodEl, data:prodData, options:prodOptions });

//--------------------------------------생산량 차트 끝-------------------------------------------------------//

//Ajax
function chartAjax(){
	$.ajax({
			url : "${path}/eqm/findEqmTemp.do",
			dataType : 'json',
			method : 'GET',
			data: {eqmId : targetEqmId},
			error : function(result){
				console.log('에러',result)
			}
		}).done(function (result){
			//result.data.contents
			console.log(result.data.contents);
			
			//초기화
			var tempDatum = {name:targetEqmId, data:[]};
			var prodDatum = {name:targetEqmId, data:[]};
			
			var tempCategories = [];
			var prodCategories = [];
			
			for(datum of result.data.contents) {
				
				tempDatum.data.push(Math.round(Number(datum.tempNow)));
				prodDatum.data.push(Number(datum.prodQy));
				
				tempCategories.push(datum.logTm.substring(11,19))
				prodCategories.push(datum.logTm.substring(11,19))
				
			}
			
			tempData.series = [tempDatum];
			tempData.categories = tempCategories;
			
			prodData.series = [prodDatum];
			prodData.categories = prodCategories;
			
			console.log(tempData);
			console.log(prodData);
			
			tempChart.setData(tempData);
			prodChart.setData(prodData);
		})
}

//setInterval

/* const intervalId = setInterval(() => {
		console.log("인터벌---")
		chartAjax();
}, 5000); */

</script>

</body>
</html>