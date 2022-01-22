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
	/* 	function openTab(evt, tabName) {
			var i, tabcontent, tablinks;
			tabcontent = document.getElementsByClassName("tabcontent"); // 컨텐츠를 불러옵니다. 
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none"; //컨텐츠 모두 숨김. 
			}
			tablinks = document.getElementsByClassName("tablinks"); //탭 불러오기. 
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", ""); //탭을 초기화시킵니다. 
			}
			document.getElementById(tabName).style.display = "block"; //해당되는 컨텐츠만 보여줍니다. 
			evt.currentTarget.className += " active"; //클릭한 탭을 활성화시킵니다. 
		} */
		
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