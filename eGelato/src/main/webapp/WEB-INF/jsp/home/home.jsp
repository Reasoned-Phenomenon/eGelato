<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
<script src="https://ajax.aspnetcdn.com/ajax/knockout/knockout-2.2.1.js"></script>
<script src="${path}/resources/js/sevenSeg.js"></script>	
<style>

	table {
		background-color: black;
	}
	
	p {
		font-size: 80px;
		color: white;
	}
	
</style>
</head>
<body>
<br>
<br>
<br>
<br>
<div align="center">
	<table>
		<tr>
			<th><p>목표수량 &nbsp;</p></th>
			<td>
				<div id="targetProdQy" style="width:500px; height:200px;"></div>
			</td>
		</tr>
		<tr>
			<th><p>생산수량 &nbsp;</p></th>
			<td>
				<div id="prodQy" style="width:500px; height:200px;"></div>
			</td>
		</tr>
		<tr>
			<th><p>미달수량 &nbsp;</p></th>
			<td>
				<div id="unProducedQy" style="width:500px; height:200px;"></div>
			</td>
		</tr>
	</table>

</div>
<script>

let targetProdQy = Number(${prodQy[0].prodQy});
let prodQy = Number(${prodQy[1].prodQy});
let unProducedQy = Number(targetProdQy)-Number(prodQy);


$("#targetProdQy").sevenSeg({ digits: 5, value: targetProdQy });
$("#prodQy").sevenSeg({ digits: 5, value: prodQy });
$("#unProducedQy").sevenSeg({ digits: 5, value: unProducedQy });

</script>
</body>
</html>
