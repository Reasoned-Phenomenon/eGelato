<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>실시간 설비 상태(온도/생산량)</title>

</head>
<body>
<h2>실시간 설비 상태</h2>

	<div align="center">
		<div id="chart-temp"></div>
	</div>
	
	<hr>
	
	<div align="center">
		<div id="chart-prod"></div>
	</div>
	
<script>
//--------------------------------------온도 차트 시작-------------------------------------------------------//
//온도 차트 생성
var tempEl = document.getElementById('chart-temp');

var tempData = {
	categories: [],
	series: [],
};
 
var tempOptions = { 
		chart: { title: '실시간 설비 온도', width: 1400, height: 350 },
		xAxis: {
			title: '시간',
			date: { format: 'hh:mm:ss' }
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
  chart: { title: '실시간 설비 생산량', width: 1400, height: 350 },
  xAxis: {
    title: '시간',
    date: { format: 'hh:mm:ss' }
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

//선언
let tmFlag;
let eqmIdFlag;
let numFlag;
let lastLogTm;

//Ajax
function chartAjax(){
	$.ajax({
			url : "${path}/eqm/selectNowEqm.do",
			dataType : 'json',
			method : 'GET',
			error : function(result){
				console.log('에러',result)
			}
		}).done(function (result){
			console.log(result.data.contents);
			let eqmData = result.data.contents;
			
			prodData = {categories: [],series: [],};
			tempData = {categories: [],series: [],};
			
			let tempItem = {name:'', data:[]};
			let prodItem = {name:'', data:[]};
			
			eqmIdFlag = '';
			numFlag = 0;
			
			let logSet = new Set();
			
			for(let i = 0 ; i < eqmData.length ; i ++ ) {
				
				if (i == eqmData.length-1 ) {
					tempData.series.push(tempItem);
					prodData.series.push(prodItem);
				}
				
				console.log(numFlag,eqmData[i].eqmId);
				
				if ( eqmIdFlag != eqmData[i].eqmId) {
					
					numFlag = 0;
					
					if( tempItem.name !='') {
						tempData.series.push(tempItem);
						prodData.series.push(prodItem);
					}
					
					eqmIdFlag = eqmData[i].eqmId;
					
					tempItem = {name:'', data:[]};
					prodItem = {name:'', data:[]};
					
					tempItem.name = eqmData[i].eqmId;
					prodItem.name = eqmData[i].eqmId;
				} 
				
				if(numFlag > 9) {
					continue;
				}
				
				logSet.add(eqmData[i].logTm);
				
				tempItem.data.push({x:eqmData[i].logTm, y:Number(eqmData[i].tempNow)});
				prodItem.data.push({x:eqmData[i].logTm, y:Number(eqmData[i].prodQy)});
				
				numFlag++;
				
			}
			
			let tmArr = Array.from(logSet).sort();
			
			for(let i=0; i < tmArr.length ; i ++ ) {
				tempData.categories.push(tmArr[i]);
				prodData.categories.push(tmArr[i]);
			}
			
			lastLogTm = tmArr[tmArr.length-1];
			console.log(lastLogTm)
			tempChart.setData(tempData);
			prodChart.setData(prodData);
			
		})
}

chartAjax();

//setInterval
const intervalId = setInterval(() => {
		console.log("인터벌---")
		//updateDataAjax();
		chartAjax();
}, 5000);


</script>

</body>
</html>