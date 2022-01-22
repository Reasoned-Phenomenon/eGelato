<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOM 코드 관리 페이지</title>
</head>
<body>
		<div>
			<br>
			<h3>BOM 코드 관리</h3>
		</div>
		
		<form id="" name="" method="">

			<div>
			<br>
				<label>제품코드</label>
	      			<input type="text" id="prdtId" name="prdtId">
	      			<button type="button" id="serachBtn">검색</button>&ensp;&ensp;&ensp;
	      					
	      		<label>제품명</label>
	      			<input type="text" id="prdtNm" name="prdtNm"> &ensp;
	      			
	      		<label>소모량</label>
	      			<input type="text" id="qy" name="qy"> &ensp;
	      		
	      		<label>업체명</label>
	      			<input type="text" id="vendName" name="vendName"> &ensp;		
	      		
	      		<label>사용여부</label>
	      			<input type="checkBox" id="useYn" name="useYn" checked> &ensp;		
			    <br>
	      	 </div>
				<div>
					<button type="button" class="btn cur-p btn-outline-primary" id="FindBtn">조회</button>
					<button type="button" class="btn cur-p btn-outline-primary" id="AddBtn">추가</button>
					<button type="button" class="btn cur-p btn-outline-primary" id="SaveBtn">저장</button>
					<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
				
				</div>
		</form>
		

<div id="bomGrid" style="width: 100%"></div>
<div id="bomModal" style="width: 100%"></div>
		
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
var bomGrid = new Grid({
	el: document.getElementById('bomGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/findBomList.do', method: 'GET'},
	    modifyData : { url: '${path}/com/bomCodeModifyData.do', method: 'PUT'} 
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	columns:[
			{
			  header: 'BOM코드',
			  name: 'bomId',
			  editor:'text',
			  align: 'center'
		      
			},
			{
			  header: '제품코드',
			  name: 'prdtId',
			  editor:'text',
			  align: 'center'
	          
			},
			{
			  header: '자재코드',
			  name: 'rwmatrId',
			  align: 'center'
		      
			},
			{
			  header: '자재명',
			  name: 'nm',
			  align: 'center'
			      
			},
			{
			  header: '소모량',
			  name: 'qy',
			  editor:'text',
			  align: 'center'
			  
			},
			{
			  header: '사용 공정명',
			  name: 'prcsNm',
			  align: 'center'
		     
			},
			
			{
			  header: '단계구분',
			  name: 'fg',
			  editor:'text',
			  align: 'center'
			  
			},
			{
        	  header: '비고',
		      name: 'remk',
		      editor:'text',
		      align: 'center'
		      
			},
			{
              header: '사용여부',
			  name: 'useYn',
			  editor:'text',
			  align: 'center'
			  
			}
		]
});
	
	// 추가 버튼 이벤트.
	AddBtn.addEventListener("click", function(){
		bomGrid.appendRow();
	});
	
	// 저장(등록) 버튼 이벤트.
	SaveBtn.addEventListener("click", function(){	
		bomGrid.blur();
		bomGrid.request('modifyData');
	});
	
	
	
	// 모달창 생성 함수.
	$(function () {
		dialog = $( "#bomModal" ).dialog({
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
	
	// 제품 검색 버튼 이벤트.
	serachBtn.addEventListener("click", function() {
		console.log("00000");
		console.log("모달클릭")
		dialog.dialog( "open" );
		
		 // 컨트롤러에 보내주고 따로 모달은 jsp 만들 필요가 없으니깐  
		 $('#bomModal').load("${path}/com/bomModal.do",function () {
			 console.log('로드됨')
		})
		
	})
	
	// 제품코드 인풋 태그에 값들어가게 함.
	function getModal(Param) {
		console.log(Param);
		$("#prdtId").val(Param.prdtId);
		$("#prdtNm").val(Param.prdtNm);
		$("#qy").val(Param.qy);
		$("#vendName").val(Param.vendName);
		$("#useYn").val(Param.useYn);
		
		dialog.dialog("close");
	}
	
	// 조회 버튼 이벤트.
	FindBtn.addEventListener("click", function(){
		    console.log("조회버튼 클릭");
		    var prdtId = document.getElementById("prdtId").value;
			var prdtNm = document.getElementById("prdtNm").value;
			
			var qy = document.getElementById("qy").value;
			var vendName = document.getElementById("vendName").value;
			var useYn = document.getElementById("useYn").value;
			
			console.log("prdtId");
			console.log("prdtNm");
			console.log("qy");
			console.log("vendName");
			console.log("useYn");
			
			bomGrid.readData(1, {'prdtId':prdtId, 'prdtNm':prdtNm, 'qy':qy, 'vendName':vendName, 'useYn':useYn }, true);
	});
	

</script>		
		
		
</body>
</html>