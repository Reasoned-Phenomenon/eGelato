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
    
    const data = {
      categories: [],
      series: [
        {
          name: 'eqmId',
          data: [],
        }
      ],
    };
    
    const options = { 
      chart: { title:  '실시간 설비 온도', width: 1000, height: 500 },
      xAxis: {
        title: 'Month',
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

    const chart = toastui.Chart.lineChart({ el, data, options });
    
    var logTm = 0;
    var tempNow;
    
    //5초마다 반영
    const intervalId = setInterval(() => {
    	logTm += 1;
      const random = Math.round(Math.random() * 100);
      const random2 = Math.round(Math.random() * 100);
      chart.addData([random, random2], logTm);
    }, 5000);
    
    
    //값 가져오기
    function selectState() {
    	var state = $('#state option:selected').val();
    	console.log(state)
    	if(state == '온도'){
			$.ajax({
				url : "${path}/eqm/findEqmTemp.do",
				dataType : 'json',
				method : 'GET',
				error : function(result){
					console.log('에러',result)
				}
			}).done(function (result){
				console.log("값내놔",result)
				console.log(result.data.contents.length)
				for(let i = 0; i<result.data.contents.length; i++){
					data.categories.push(result.data.contents[i].logTm)
					data.series.data.push(result.data.contents[i].tempNow)
				} 
				chart.setData({categories : data.categories, series : data.series.data});
			}) 
    	} else{
    		$.ajax({
				url : "${path}/eqm/findOutputTemp.do",
				dataType : 'json',
				method : 'POST',
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