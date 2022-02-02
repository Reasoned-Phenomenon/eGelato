<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온도/UPH</title>
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
</head>
<body>
	<div id="chart-area"></div>
	<div id="tab2" class="tabcontent" style="display: none;">UPH
		toast UI</div>

	<script>
		
		const el = document.getElementById('chart-area');

		const data = {
				categories: [
					'09AM',
					'10AM',
					'11AM',
					'12PM',
					'13PM',
					'14PM',
					'15PM',
					'16PM',
					'17PM',
					'18PM'
				],
				series: [
					{
						name:'설비명',
						data:[10, 25, 15, 15, 20, 23, 20, 25, 23, 20]
					}
				]
		};
		
		 const options = {
		        chart: { title: 'UPH', width: 1000, height: 500 },
		        xAxis: {
		          title: {text:'시간'},
		        },
		        yAxis: {
		          title: 'UPH',
		        },
		          legend: {
		          align: 'bottom',
		        }
		      };

		 const chart = toastui.Chart.lineChart({ el, data, options });
		
	</script>
</body>
</html>