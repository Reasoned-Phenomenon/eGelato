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
      series: [
        {
          name: 'Temperature',
          data: [10],
        },
      ],
    };
    const options = {
      chart: { title: '설비1 실시간 온도', width: 550, height: 500 },
      series: {
        solid: true,
        dataLabels: { visible: true, offsetY: -30, formatter: (value) => `\${value}℃` },
      },
      theme: {
        circularAxis: {
          lineWidth: 0,
          strokeStyle: 'rgba(0, 0, 0, 0)',
          tick: {
            lineWidth: 0,
            strokeStyle: 'rgba(0, 0, 0, 0)',
          },
          label: {
            color: 'rgba(0, 0, 0, 0)',
          },
        },
        series: {
          dataLabels: {
            fontSize: 40,
            fontFamily: 'Impact',
            fontWeight: 600,
            color: '#00a9ff',
            textBubble: {
              visible: false,
            },
          },
        },
      },
    };

    const chart = toastui.Chart.gaugeChart({ el, data, options });
  
	</script>
</body>
</html>