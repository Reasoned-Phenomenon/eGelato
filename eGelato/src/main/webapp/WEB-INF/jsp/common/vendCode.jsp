<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 코드 관리 페이지</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<h2>거래처 코드 관리</h2>
	<div>
		<table>
			<tbody>
				<tr>
					<th>거래처 코드</th>
					<td><input type="text" id="vendId" name="vendId" readonly></td>
					<th>거래처 명*</th>
					<td><input type="text" id="vendName" name="vendName"></td>
				</tr>
				<tr>
					<th>사업자 등록번호*</th>
					<td><input type="text" id="bizno" name="bizno"></td>
					<th>전화번호*</th>
					<td><input type="text" id="telno" name="telno"></td>
				</tr>
				<tr>
					<th>비 고*</th>
					<td><input type="text" id="remk" name="remk"></td>
					<th>구 분*</th>
					<td><select id="fg" name="fg">
						<option value="VEND01">구매처</option>
						<option value="VEND02">판매처</option>
						<option value="VEND03">거래처</option>
						<option value="VEND04">설비구매처</option>
					</select></td>
					<td><button type="button" id="reset">초기화</button>
						<button type="button" id="SearchBtn">조회</button>
						<button type="button" id="SaveBtn">저장</button></td>
				</tr>
			</tbody>
		</table>
	</div>

	<div id="vendCodeGrid" style="width: 100%"></div>

	<script>
let dialog;

//modify구분하기위한 변수
let flag;

var Grid = tui.Grid;



//그리드 생성.
var vendCodeGrid = new Grid({
	el: document.getElementById('vendCodeGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/vendCodeList.do', method: 'GET'},
	   // modifyData : { url: '${path}/com/vendCodeModifyData.do', method: 'PUT'}
	  },
	  contentType: 'application/json'
	  
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	bodyHeight : 500,
	columns:[
			{
			  header: '거래처 코드',
			  name: 'vendId'
			},
			{
			  header: '거래처 명',
			  name: 'vendName'
			},
			{
			  header: '사업자 등록번호',
			  name: 'bizno',
			  align: 'right'
			},
			{
			  header: '전화 번호',
			  name: 'telno',
			  align: 'right'
			},
			{
			  header: '비 고',
			  name: 'remk'
			},
			{
			  header: '구 분',
			  name: 'fg'
			},
			{
			header: '거래처 코드',
			name: 'fgCode',
			hidden: true
			}

		]
});

 // 더블클릭시 그리드에서 한행 선택 입력폼에 값 들어가게 함.
 vendCodeGrid.on("dblclick", (ev) => {
		
	    $("#vendId").val(vendCodeGrid.getValue(ev["rowKey"],"vendId"));
		$("#vendName").val(vendCodeGrid.getValue(ev["rowKey"],"vendName"));
		$("#bizno").val(vendCodeGrid.getValue(ev["rowKey"],"bizno"));
		$("#telno").val(vendCodeGrid.getValue(ev["rowKey"],"telno"));
		$("#remk").val(vendCodeGrid.getValue(ev["rowKey"],"remk"));
		
		fg.value = vendCodeGrid.getValue(ev.rowKey,"fgCode");
		
	});

 // 조회 버튼 이벤트.
 SearchBtn.addEventListener("click", function() {
		console.log("조회버튼 클릭");
		 var vendId = document.getElementById("vendId").value;
		 var vendName = document.getElementById("vendName").value; 
		 var bizno = document.getElementById("bizno").value;  
		 var telno = document.getElementById("telno").value;    
		 var remk = document.getElementById("remk").value;    
		 var fg = document.getElementById("fg").value;    
		
		 vendCodeGrid.readData(1, {'vendId':vendId, 'vendName':vendName,'bizno':bizno,'telno':telno, 'remk':remk, 'fg':fg}, true);
	});
 
 
	// 초기화 버튼.
	$("#reset").on("click",function(){
		$("#vendId").val("");
		$("#vendName").val("");
		$("#bizno").val("");
		$("#telno").val("");
		$("#remk").val("");	
		$("#fg").val("");	
	});
 
 // 그리드 행 추가 버튼 이벤트.
/*  	AddBtn.addEventListener("click", function(){
 		vendCodeGrid.prependRow();
	}); */
 
	//컨트롤러 응답
/* 	vendCodeGrid.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			vendCodeGrid.readData(1);
			flag = 'X';
		}
		
	}); */
 
	
  // 등록 버튼 이벤트.(등록과 수정)
		$("#SaveBtn").on("click",function(){
			
			var vendId = $("#vendId").val();
			var vendName = $("#vendName").val();
			var bizno = $("#bizno").val();
			var telno = $("#telno").val();
			var remk = $("#remk").val();
			var fg = $("#fg option:selected").val();
			console.log(fg);

			if (vendId =='') {
				$.ajax({
					url:"${path}/com/insertvendCode.do",
					method :"post",
					data: {
						vendId : vendId ,
						vendName : vendName,
						bizno : bizno,
						telno : telno,
						remk : remk,
						fg : $("#fg option:selected").val()
					
					},
					success : function(res) {
						vendCodeGrid.readData(1,{},true)
						//console.log(res);
						alert("등록 되었습니다.");
						vendCodeGrid.refreshLayout();
					},
					error : function() {
						alert("등록 실패했습니다.");
					}	
				})
				
			} else if (vendId !='') {
				
				$.ajax({
					url:"${path}/com/updatevendCode.do",
					method :"post",
					data: {
						vendId : vendId ,
						vendName : vendName,
						bizno : bizno,
						telno : telno,
						remk : remk,
						fg : $("#fg option:selected").val()
						
					},
					success : function(res) {
						vendCodeGrid.readData(1,{},true)
						//console.log(res);
						alert("수정 되었습니다.");
						vendCodeGrid.refreshLayout();
					},
					error : function() {
						alert("수정 실패했습니다.");
					}
						
				})
				
			}
			
		});

 
  

</script>
</body>
</html>