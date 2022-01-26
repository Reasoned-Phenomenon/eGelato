<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 코드 관리 페이지</title>
</head>
<body>

	<div class="container">
      <div class="flex row">
         <div class="col-4">
            <br>
            <h3>자재 코드 관리</h3>
            <div align="right">
            </div>
            <div id="rwmatrGrid"></div>
         </div>
         <div class="col-8">
            <br>
            	<br>
            <table border="1">
               <tbody>
                  <tr> 
                     <th>자재코드*</th>
                     <td><input type="text" id="rwmatrId" name="rwmatrId" readonly></td>
                     <th>자재명*</th>
                     <td><input type="text" id="nm" name="nm"></td>
                  </tr>
                  <tr>
                     <th>규격</th>
                     <td><input type="text" id="spec" name="spec"></td>
                     <th>작업 단위</th>
                     <td><input type="text" id="wkUnit" name="wkUnit"></td>
                    
                  </tr>
                  <tr>
                     <th>입고 업체</th>
                     <td><input type="text" id="vendId" name="vendId">
                        <button type="button" id="serachVendIdBtn">검색</button></td>
                     <th>업체명</th>
                     <td><input type="text" id="vendName" name="vendName" readonly></td>
                  </tr>
                  <tr>
                     <th>제품 구분</th>
                     <td><select id="fg" name="fg">
                     <option value="STEP01">원자재</option>
                     <option value="STEP02">반제품</option>
                     </select>
                      <th>안전 재고</th>
                     <td><input type="text" id="safStc" name="safStc"></td>
                  </tr>
                  <tr>
                     <th>사용유무</th>
                     <td><input type="checkbox" id="useYn" name="useYn" checked></td>
                  </tr>
               </tbody>
            </table>
            		<button id="reset" value="초기화"
						class="btn cur-p btn-outline-dark">초기화</button>
					<button id="AddBtn" class="btn cur-p btn-outline-dark">저장</button>
					<button id="UpdateBtn" class="btn cur-p btn-outline-dark">수정</button>
					
         </div>
      </div>
   </div>
<div id="vendModal"></div>


<script>
let dialog;

var Grid = tui.Grid;	


//그리드 테마.
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	    }
	  }
});

//그리드 생성.
var rwmatrGrid = new Grid({
	el: document.getElementById('rwmatrGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/findRwmatrList.do', method: 'GET'},
	     
	  },
	  contentType: 'application/json',
	 
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	columns:[
			{
			  header: '자재 코드',
			  name: 'rwmatrId',
			  align: 'center'
		      
			},
			{
			  header: '자재 명',
			  name: 'nm',
			  align: 'center'
	          
			},
			{
			  header: '규 격',
			  name: 'spec',
			  align: 'center'
		      
			},
			{
			  header: '업체 코드',
			  name: 'vendId',
			  align: 'center',
			  hidden: true
			      
		   },
		   {
			  header: '작업 단위',
			  name: 'wkUnit',
			  align: 'center',
			  hidden: true
				      
	       },
	       {
			  header: '안전 재고',
			  name: 'safStc',
		      align: 'center',
		      hidden: true
					      
		   },
		   {
			  header: '제품 구분',
			  name: 'fg',
			  align: 'center',
			  hidden: true
						      
			},
		   
		]
});

//더블클릭시 한 행 선택 입력폼에 값 들어가게 하기.
		rwmatrGrid.on("dblclick", (ev) => {
			
			$("#rwmatrId").val(rwmatrGrid.getValue(ev["rowKey"],"rwmatrId"));
			$("#nm").val(rwmatrGrid.getValue(ev["rowKey"],"nm"));
			$("#spec").val(rwmatrGrid.getValue(ev["rowKey"],"spec"));
			$("#wkUnit").val(rwmatrGrid.getValue(ev["rowKey"],"wkUnit"));
			$("#safStc").val(rwmatrGrid.getValue(ev["rowKey"],"safStc"));
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
			var spec = $("#spec").val();
			var wkUnit = $("#wkUnit").val();
			var safStc = $("#safStc").val();
			var vendId = $("#vendId").val();
			var vendName = $("#vendName").val();
			var fg = $("#fg").val();
			var useYn =$("#useYn").val();

			$.ajax({
				url:"${path}/com/insertrwmatrCode.do",
				method :"post",
				data: {
					rwmatrId : rwmatrId ,
					nm : nm,
					spec : spec,
					wkUnit : wkUnit,
					safStc : safStc,
					vendId : vendId,
					vendName : vendName,
					fg : fg,
					useYn : useYn
				},
				success : function(res) {
					rwmatrGrid.readData(1,{},true)
					console.log(res);
				}
					
			})
		});
		
		
		// 수정 버튼 이벤트.
		$("#UpdateBtn").on("click", function(){
			
			var rwmatrId = $("#rwmatrId").val();
			var nm = $("#nm").val();
			var spec = $("#spec").val();
			var wkUnit = $("#wkUnit").val();
			var safStc = $("#safStc").val();
			var vendId = $("#vendId").val();
			var vendName = $("#vendName").val();
			var fg = $("#fg").val();
			var useYn =$("#useYn").val();
			
			$.ajax({
				url:"${path}/com/updaterwmatrCode.do",
				method :"post",
				data: {
					rwmatrId : rwmatrId ,
					nm : nm,
					spec : spec,
					wkUnit : wkUnit,
					safStc : safStc,
					vendId : vendId,
					vendName : vendName,
					fg : fg,
					useYn : useYn
				},
				success : function(res) {
					rwmatrGrid.readData(1,{},true)
					console.log(res);
				}
					
			})
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
			
		});
		
		// 모달창 생성 함수.
		$(function () {
			dialog = $( "#vendModal" ).dialog({
				autoOpen: false,
				height: 500,
				width: 700,
				modal: true,
				buttons: {
				// 선택하는 버튼 넣어두기!. 옵션? 어떤거 잇는 지 찾아보기.
				Cancel: function() {
				
				}
				}
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