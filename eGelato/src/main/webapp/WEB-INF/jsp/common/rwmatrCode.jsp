<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 코드 관리 페이지</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<div class="container col-sm-12" style="margin: 0px; width: 100%;">
		<div class="flex row">
			<div class="col-7">
				<h2>자재 코드 관리</h2>
				<hr>
				<br>
				<div align="right"></div>
				<div id="rwmatrGrid" style="width: 100%"></div>
			</div>
			<div class="col-5">
			<form action="">
				<table class="table table-bbs" style="margin-top: 75%;">
					<tbody>
						<tr>
							<th>자재코드</th>
							<td><input type="text" id="rwmatrId" name="rwmatrId"
								readonly></td>
							<th>자재명*</th>
							<td><input type="text" id="nm" name="nm" required></td>
						</tr>
						<tr>
							<th>규격</th>
							<td><select id="spec" name="spec">
									<option value="SPEC01">10KG</option>
									<option value="SPEC02">30KG</option>
							</select></td>

							<th>작업 단위</th>
							<td><select id="wkUnit" name="wkUnit">
									<option value="UNIT01">EA</option>
									<option value="UNIT02">BOX</option>
									<option value="UNIT03">BUNDEL</option>
							</select></td>

						</tr>
						<tr>
							<th>입고 업체</th>
							<td colspan="3"><input type="text" id="vendId" name="vendId"
								readonly>
								<button type="button" id="serachVendIdBtn" class="btn-modal"></button>
								<input type="text" id="vendName" name="vendName"
								placeholder="업체명" style="width: 70px;" readonly></td>
						</tr>
						<tr>
							<th>제품 구분</th>
							<td><select id="fg" name="fg">
									<option value="STEP01" selected>원자재</option>
									<option value="STEP02">반제품</option>
							</select></td>
							<th>안전 재고*</th>
							<td><input type="text" id="safStc" name="safStc"></td>
						</tr>
						<tr>
							<th>사용유무</th>
							<td><input type="checkbox" id="useYn" name="useYn" checked></td>
						</tr>
					</tbody>
				</table>
				</form>
				<div>
					<button id="reset" value="초기화" class="btn cur-p btn-outline-dark">초기화</button>
					<button id="AddBtn" class="btn cur-p btn-outline-dark">저장</button>
					<!-- <input type="hidden" name="" value=""> -->

				</div>
			</div>
		</div>
	</div>

	<div id="vendModal" title="거래처 코드 목록"></div>


	<script>
let dialog;

var Grid = tui.Grid;	

toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 
		}

//그리드 생성.
var rwmatrGrid = new Grid({
	el: document.getElementById('rwmatrGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/findRwmatrList.do', method: 'GET'},
	     
	  },
	  contentType: 'application/json'
	  
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	bodyHeight : 600,
	columns:[
			{
			  header: '자재 코드',
			  name: 'rwmatrId'
		      
			},
			{
			  header: '자재 명',
			  name: 'nm'
	          
			},
			{
			  header: '규 격',
			  name: 'spec',
			  align: 'right'
		      
			},
			{
			  header: '업체 코드',
			  name: 'vendId',
			  hidden: true
			      
		   },
		   {
			  header: '작업 단위',
			  name: 'wkUnit'
	       },
	       {
			  header: '안전 재고',
			  name: 'safStc',
			  align: 'right'
					      
		   },
		   {
			  header: '제품 구분',
			  name: 'fg'    
			},
			{
			  header: '제품구분코드 ',
			  name: 'fgCode',
			  hidden: true
			},
			{
			  header: '규격구분코드 ',
			  name: 'specCode',
			  hidden: true
			},
			{
			  header: '작업단위코드 ',
			  name: 'wkUnitCode',
			  hidden: true
			}
		   
		]
});

//더블클릭시 한 행 선택 입력폼에 값 들어가게 하기.
		rwmatrGrid.on("dblclick", (ev) => {
			
			$("#rwmatrId").val(rwmatrGrid.getValue(ev["rowKey"],"rwmatrId"));
			$("#nm").val(rwmatrGrid.getValue(ev["rowKey"],"nm"));
			//$("#spec").val(rwmatrGrid.getValue(ev["rowKey"],"spec"));
			//$("#wkUnit").val(rwmatrGrid.getValue(ev["rowKey"],"wkUnit"));
			$("#safStc").val(rwmatrGrid.getValue(ev["rowKey"],"safStc"));
			
			spec.value = rwmatrGrid.getValue(ev.rowKey,"specCode");
			wkUnit.value = rwmatrGrid.getValue(ev.rowKey,"wkUnitCode");
			fg.value = rwmatrGrid.getValue(ev.rowKey,"fgCode");
			
			
		//	$("#vendName").val(rwmatrGrid.getValue(ev["rowKey"],"vendName"));
		//	$("#fg").val(rwmatrGrid.getValue(ev["rowKey"],"fg"));
		/* 	var useYn = $('input:checkbox[id="useYn"]').is(":checked") == true

			if (useYn == true) {
				useYn = "Y";
			} else {
				useYn = "N";
			}
			console.log(useYn); */
			
			//rwmatrGrid.getValue(ev["rowKey"],"useYn")=='Y'?$("#useYn").prop("checked",true):$("#notUse").prop("checked",true);

			
		});
	
		// 저장 (등록) 버튼 이벤트.
		$("#AddBtn").on("click",function(){
			
			var rwmatrId = $("#rwmatrId").val();
			var nm = $("#nm").val();
			var spec = $("#spec option:selected").val();
			var wkUnit =  $("#wkUnit option:selected").val();
			var safStc = $("#safStc").val();
			var vendId = $("#vendId").val();
			var vendName = $("#vendName").val();
			var fg = $("#fg option:selected").val();
			var useYn =$("#useYn").val();

			if (rwmatrId =='') {
				if(nm =='' || safStc =='') {
					toastr.info('필수사항을 입력해주세요.','Gelato');
					//alert("자재 명을 입력하세요.");
					return;
				}

				$.ajax({
					url:"${path}/com/insertrwmatrCode.do",
					method :"post",
					data: {
						rwmatrId : rwmatrId ,
						nm : nm,
						spec : $("#spec option:selected").val(),
						wkUnit : $("#wkUnit option:selected").val(),
						safStc : safStc,
						vendId : vendId,
						vendName : vendName,
						fg : $("#fg option:selected").val(),
						useYn : useYn
					},
					success : function(res) {
						rwmatrGrid.readData(1,{},true)
						//console.log(res);
						//alert("등록 되었습니다.");
						toastr.success('등록 되었습니다.','Gelato');
						rwmatrGrid.refreshLayout();
					},
					error : function() {
						//alert("등록 실패했습니다.");
						toastr.error('등록 실패' ,'Gelato');
					}	
				})
				
			} else if (rwmatrId !='') {
				
				$.ajax({
					url:"${path}/com/updaterwmatrCode.do",
					method :"post",
					data: {
						rwmatrId : rwmatrId ,
						nm : nm,
						spec : $("#spec option:selected").val(),
						wkUnit : $("#wkUnit option:selected").val(),
						safStc : safStc,
						vendId : vendId,
						vendName : vendName,
						fg : $("#fg option:selected").val(),
						useYn : useYn
					},
					success : function(res) {
						rwmatrGrid.readData(1,{},true)
						//console.log(res);
						//alert("수정 되었습니다.");
						toastr.success('수정 되었습니다.','Gelato');
						rwmatrGrid.refreshLayout();
					},
					error : function() {
						//alert("수정 실패했습니다.");
						toastr.error('수정 실패' ,'Gelato');
					}
						
				})
				
			}
			
		});
		
		
		// 초기화 버튼 이벤트.
		$("#reset").on("click",function(){
			$("#rwmatrId").val("");
			$("#nm").val("");
			$("#spec").val("");
			$("#wkUnit").val("");
			$("#vendId").val("");
			$("#vendName").val("");
			$("#fg").val("");
			$("#useYn").val("");
			$("#safStc").val("");
			
		});
		
		// 모달창 생성 함수.
		$(function () {
			dialog = $( "#vendModal" ).dialog({
				autoOpen: false,
				height: 500,
				width: 700,
				modal: true
				
			})
		});
		
		// 거래처 검색 버튼 이벤트.
		serachVendIdBtn.addEventListener("click", function() {
			
			console.log("거래처 검색 클릭")
			dialog.dialog( "open" );
			
			 // 컨트롤러에 보내주고 따로 모달은 jsp 만들 필요가 없으니깐  
			 $('#vendModal').load("${path}/com/vendModal.do",function () {
				 console.log('로드됨')
			})
			
		})
		
		// 거래처 인풋 태그에 값들어가게 함.
		function getModalData(Param) {
		console.log(Param);
		$("#vendId").val(Param.vendId);
		$("#vendName").val(Param.vendName);

		dialog.dialog("close");
	}
		
</script>
</body>
</html>