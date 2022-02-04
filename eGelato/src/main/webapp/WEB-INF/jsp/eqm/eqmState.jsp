<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
	<div>
		<label>모니터링</label><select id="state" onchange="selectState()">
			<option value="온도">온도</option>
			<option value="생산량">생산량</option>
		</select>
	</div>
	<div id="chart-area"></div>
	<script>

	
     const el = document.getElementById('chart-area');
    
     /*const data = {
    	        series: [
    	          {
    	            name: 'SiteA',
    	            data: [
    	              ['08/22/2020 10:00:00', 202],
    	              ['08/22/2020 10:05:00', 212],
    	              ['08/22/2020 10:10:00', 222],
    	              ['08/22/2020 10:15:00', 351],
    	              ['08/22/2020 10:20:00', 412],
    	              ['08/22/2020 10:25:00', 420],
    	              ['08/22/2020 10:30:00', 300],
    	              ['08/22/2020 10:35:00', 213],
    	              ['08/22/2020 10:40:00', 230],
    	              ['08/22/2020 10:45:00', 220],
    	              ['08/22/2020 10:50:00', 234],
    	              ['08/22/2020 10:55:00', 210],
    	              ['08/22/2020 11:00:00', 220],
    	            ],
    	          },
    	          {
    	            name: 'SiteB',
    	            data: [
    	              ['08/22/2020 10:00:00', 312],
    	              ['08/22/2020 10:10:00', 320],
    	              ['08/22/2020 10:20:00', 295],
    	              ['08/22/2020 10:30:00', 300],
    	              ['08/22/2020 10:40:00', 320],
    	              ['08/22/2020 10:50:00', 30],
    	              ['08/22/2020 11:00:00', 20],
    	            ],
    	          },
    	        ],
    	      };
    	      const options = {
    	        chart: { title: 'Concurrent user', width: 1000, height: 500 },
    	        xAxis: { pointOnColumn: true, title: 'minute', date: { format: 'hh:mm:ss' }, },
    	        yAxis: { title: 'users' },
    	      };

    	      const chart = toastui.Chart.lineChart({ el, data, options });*/
     
    var logTm = 0;
    var tempNow; 
    var data = {};
    var options = {};
    var chart;
    
    
    //5초마다 반영  
    const intervalId = setInterval(() => {
    	logTm += 1;
      const random = Math.round(Math.random() * 100);
      chart.addData([60], new Date('2022-02-03T21:29:30'));
    }, 5000);   
    
    $(function(){
   	 var state = $('#state option:selected').val();
    	console.log(state)
			$.ajax({
				url : "${path}/eqm/findEqmTemp.do",
				dataType : 'json',
				method : 'GET',
				async : false,
				error : function(result){
					console.log('에러',result)
				}
			}).done(function (result){
				console.log(result)
				 data = {
			      series: [
			        {
			          name: 'eqmId',
			          data: [],
			        }
			      ],
			    };
				 
				console.log("값내놔",result)
				console.log(result.data.contents.length)
				for(let i = 0; i<result.data.contents.length; i++){
					
					data.series[0].data.push([result.data.contents[i].logTm, Number(result.data.contents[i].tempNow)])
				} 
				console.log(data)
				console.log(data.series[0].data)
				
				options = { 
				      chart: { title:  '실시간 설비 온도', width: 1000, height: 500 },
				      xAxis: {
				   	    pointOnColumn: true,
				        title: '시간',
				        date : {format : 'hh:mm:ss'}
				      },
				      yAxis: {
				        title: 'Amount',
				      },
				      tooltip: {
				        formatter: (value) => `${value}°C`,
				      },
				      legend: {
				        align: 'bottom',
				      },
				      series: {
				        shift: true,
				      },
				
				    };
				chart = toastui.Chart.lineChart({ el, data, options });
				
				
				//chart.setData({'series' : [{name : 'abc', data : [data.series[0].data, ]}]});
			})
    })
    
    //값 가져오기
     function selectState() {
    	var state = $('#state option:selected').val();
    	console.log(state)
    	if(state == '온도'){
			$.ajax({
				url : "${path}/eqm/findEqmTemp.do",
				dataType : 'json',
				method : 'GET',
				async : false,
				error : function(result){
					console.log('에러',result)
				}
			}).done(function (result){
				
				 data = {
			      series: [
			        {
			          name: 'eqmId',
			          data: [],
			        }
			      ],
			    };
				 
				console.log("값내놔",result)
				console.log(result.data.contents.length)
				for(let i = 0; i<result.data.contents.length; i++){
					
					data.series[0].data.push([result.data.contents[i].logTm, Number(result.data.contents[i].tempNow)])
				} 
				console.log(data)
				console.log(data.series[0].data)
				
				options = { 
				      chart: { title:  '실시간 설비 온도', width: 1000, height: 500 },
				      xAxis: {
				   	    pointOnColumn: true,
				        title: '시간',
				        date : {format : 'hh:mm:ss'}
				      },
				      yAxis: {
				        title: 'Amount',
				      },
				      tooltip: {
				        formatter: (value) => `${value}°C`,
				      },
				      legend: {
				        align: 'bottom',
				      },
				      series: {
				        shift: true,
				      },
				
				    };
				
				
				//chart.setData({'series' : [{name : 'abc', data : [data.series[0].data, ]}]});
			}) 
    	}else {
    		$.ajax({
				url : "${path}/eqm/findEqmOutput.do",
				dataType : 'json',
				method : 'GET',
				error : function(result){
				console.log('에러',result)
				}
			}).done(function (result){
				console.log("값내놔",result)
				for(let i = 0; i<result.length; i++){
					data.categories.push(result[i])
				}
			})
    	}
    }  
    
     
     
     
	</script>
</body>
</html>