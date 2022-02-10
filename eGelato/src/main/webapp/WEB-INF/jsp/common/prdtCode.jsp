<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 코드 관리 페이지</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<h2>완제품 코드 관리</h2>
	<div>
		<table style="margin-bottom: 10px;">
			<tbody>
				<tr>
					<th>완제품 코드*</th>
					<td><input type="text" id="prdtId" name="prdtId" readonly></td>
					<th>제품명*</th>
					<td><input type="text" id="prdtNm" name="prdtNm"></td>
				</tr>
				<tr>
					<th>규격</th>
					<td><input type="text" id="spec" name="spec"></td>
					<th>단위</th>
					<td><input type="text" id="unit" name="unit"></td>
					<th>안전재고</th>
					<td><input type="text" id="safStc" name="safStc"></td>
					<td><button type="button" id="reset">초기화</button>
						<button type="button" id="SearchBtn">조회</button>
						<button type="button" id="SaveBtn">저장</button></td>
				</tr>
			</tbody>
		</table>
	</div>

	<div id="prdtCodeGrid"></div>

	<script>
let dialog;

//modify구분하기위한 변수
let flag;

var Grid = tui.Grid;



//그리드 생성.
var prdtCodeGrid = new Grid({
	el: document.getElementById('prdtCodeGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/prdtCodeList.do', method: 'GET'},
	   // modifyData : { url: '${path}/com/prdtCodeModifyData.do', method: 'PUT'}
	  },
	  contentType: 'application/json',
	  initialRequest: false

	},
	
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	bodyHeight : 550,
	columns:[
			{
			  header: '완제품 코드',
			  name: 'prdtId',
			  align: 'center'
		      
			},
			{
			  header: '제품명',
			  name: 'prdtNm',
			  align: 'center',
		      editor:'text'
	          
			},
			{
			  header: '규격',
			  name: 'spec',
			  align: 'center',
		      editor:'text'
		      
			},
			{
			  header: '단위',
			  name: 'unit',
			  align: 'center',
		      editor:'text'
			      
			},
			{
			  header: '안전 재고',
			  name: 'safStc',
			  align: 'center',
		      editor:'text'
				      
			}

		]
});
	
	// 더블클릭시 그리드에서 한행 선택 입력폼에 값 들어가게 하기.
	prdtCodeGrid.on("dblclick", (ev) => {
		$("#prdtId").val(prdtCodeGrid.getValue(ev["rowKey"],"prdtId"));
		$("#prdtNm").val(prdtCodeGrid.getValue(ev["rowKey"],"prdtNm"));
		$("#spec").val(prdtCodeGrid.getValue(ev["rowKey"],"spec"));
		$("#unit").val(prdtCodeGrid.getValue(ev["rowKey"],"unit"));
		$("#safStc").val(prdtCodeGrid.getValue(ev["rowKey"],"safStc"));
		
	});
	
	// 조회버튼 이벤트. 
	SearchBtn.addEventListener("click", function() {
		console.log("조회버튼 클릭");
		 var prdtId = document.getElementById("prdtId").value;
		 var prdtNm = document.getElementById("prdtNm").value; 
		 var spec = document.getElementById("spec").value;  
		 var unit = document.getElementById("unit").value;  
		 var safStc = document.getElementById("safStc").value;  
		
		prdtCodeGrid.readData(1,{'prdtId':prdtId, 'prdtNm':prdtNm,'spec':spec,'unit':unit,'safStc':safStc},true);
	});
	
	// 행 추가 버튼 이벤트. // 
	/* AddBtn.addEventListener("click", function(){
		prdtCodeGrid.prependRow();
	}); */
	
	// 초기화 버튼.
		$("#reset").on("click",function(){
			$("#prdtId").val("");
			$("#prdtNm").val("");
			$("#spec").val("");
			$("#unit").val("");
			$("#safStc").val("");	
		});
	
	//컨트롤러 응답
/* 	prdtCodeGrid.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			prdtCodeGrid.readData(1);
			flag = 'X';
		}
		
	}); */

	// 저장(등록과 수정) 버튼 이벤트. (alert 창 포함.)
		$("#SaveBtn").on("click",function(){
			
			var prdtId = $("#prdtId").val();
			var prdtNm = $("#prdtNm").val();
			var spec = $("#spec").val();
			var unit = $("#unit").val();
			var safStc = $("#safStc").val();
			

			if (prdtId =='') {
				$.ajax({
					url:"${path}/com/insertprdtCode.do",
					method :"post",
					data: {
						prdtId : prdtId ,
						prdtNm : prdtNm,
						spec : spec,
						unit : unit,
						safStc : safStc
					
					},
					success : function(res) {
						prdtCodeGrid.readData(1,{},true)
						console.log(res);
						alert("등록 되었습니다.");
						prdtCodeGrid.refreshLayout();
					},
					error : function() {
						alert("등록 실패했습니다.");
					}	
				})
				
			} else if (prdtId !='') {
				
				$.ajax({
					url:"${path}/com/updateprdtCode.do",
					method :"post",
					data: {
						prdtId : prdtId ,
						prdtNm : prdtNm,
						spec : spec,
						unit : unit,
						safStc : safStc
						
					},
					success : function(res) {
						prdtCodeGrid.readData(1,{},true)
						console.log(res);
						alert("수정 되었습니다.");
						prdtCodeGrid.refreshLayout();
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