<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
</head>
<body>
	<div><br>
		<label>설비명</label>
		<select>
			<option>설비1</option>
			<option>설비2</option>
			<option>설비3</option>
			<option>설비4</option>
			<option>설비5</option>
		</select>
	</div>
	<br>
	<div id="chart-area"></div>
	<script>

    const el = document.getElementById('chart-area');
    
    const data = {
      categories: [logTm],
      series: [
        {
          name: eqmName,
          data: [tempNow],
        }
      ],
    };
    
    const options = {
      chart: { title:  eqmName' Temperature', width: 1000, height: 500 },
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

    const intervalId = setInterval(() => {
      const random = Math.round(Math.random() * 100);
      const random2 = Math.round(Math.random() * 100);
      chart.addData([random, random2], logTm);
    }, 5000);
  

	</script>
</body>
</html>