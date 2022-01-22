<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비 점검 페이지(점검등록/점검내역조회)</title>
</head>
<body>
	<div>
		<br>
		<h2>점검 등록</h2>
		<br> <label>공정구분</label> <select>
			<option>공정1</option>
			<option>공정2</option>
			<option>공정3</option>
			<option>공정4</option>
		</select>
	</div>
	<div>
		<div id="grid" style="width: 600px;"></div>
		<div>
			<form>
				<table>
					<tbody>
						<tr>
							<th>설비코드 <strong>*</strong>
							</th>
							<td><input></td>
							<th>설비명</th>
							<td><input></td>
						</tr>
						<tr>
							<th>작업자</th>
							<td><input></td>
						</tr>
						<tr>
							<th>점검시작</th>
							<td><select>
									<option>09시</option>
									<option>11시</option>
									<option>13시</option>
									<option>15시</option>
									<option>17시</option>
							</select></td>
						</tr>
						<tr>
							<th>점검내역</th>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th>판정</th>
							<td><input type="radio" id="Y" value="Y">적합<input
								type="radio" id="N" value="N">부적합</td>
						</tr>
						<tr>
							<td><button>점검완료</button></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<div>
		<br>
		<h2>내역 조회</h2>
		<br> <label>구분</label> <select>
			<option>전체</option>
			<option>생산설비</option>
			<option>가공기</option>
			<option>측정기</option>
		</select> <label>공정코드</label> <select>
			<option>공정코드1</option>
			<option>공정코드2</option>
			<option>공정코드3</option>
			<option>공정코드4</option>
		</select>
		<button>조회</button>
	</div>
	<div id="grid2" style="width: 500px;"></div>
	<script>
	let arr=[];
		fetch("${pageContext.request.contextPath}/testAjax/info")
		.then(response=> response.json())
		.then(result => {
			for (item of result) {
				arr.push(item)
			}
			grid.resetData(arr);
		})
			
	const grid = new tui.Grid({
	      el: document.getElementById('grid'),
		  data: arr,
	      scrollX: false,
	      scrollY: false,
	      columns: [
	        {
	          header: '설비코드',
	          name: 'employeeId'
	        },
	        {
	          header: '설비명',
	          name: 'lastName'
	        },
	        {
	          header: '공정명',
	          name: 'salary'
	        },
	        {
	          header: '정기점검',
	          name: 'salary'
	        }
	      ]
	    });
		
		const grid2 = new tui.Grid({
		      el: document.getElementById('grid2'),
			  data: arr,
		      scrollX: false,
		      scrollY: false,
		      columns: [
		        {
		          header: '설비코드',
		          name: 'employeeId'
		        },
		        {
		          header: '설비명',
		          name: 'lastName'
		        },
		        {
		          header: '점검일자',
		          name: 'salary'
		        },
		        {
		          header: '판정',
		          name: 'salary'
		        },
		        {
		          header: '점검내역',
		          name: 'salary'
		        }
		      ]
		    });
</script>
</body>
</html>