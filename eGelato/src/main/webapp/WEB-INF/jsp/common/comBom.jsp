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
		
		<form>

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
				<div style="float: right;">
					<button type="button" class="btn cur-p btn-outline-primary" id="FindBtn">조회</button>
					<button type="button" class="btn cur-p btn-outline-primary" id="AddBtn">추가</button>
					<button type="button" class="btn cur-p btn-outline-primary" id="SaveBtn">저장</button>
					<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
				
				</div>
		</form>
		

<div id="bomGrid" style="width: 100%"></div>
<div id="bomModal" title="제품 코드 목록"></div>
<div id="rwmatrCodeModal" title="자재 코드 목록"></div>
<div id="prcsCodeModal"  title="공정 코드 목록"></div>
		
<script>
let dialog;

let rowkey = '';

let useYn = '';

//modify구분하기위한 변수
let flag;

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
	bodyHeight: 600,
	columns:[
			{
			  header: 'BOM코드',
			  name: 'bomId',
			  align: 'center'
		      
			},
			{
			  header: '제품코드',
			  name: 'prdtId',
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
			  header: '공정 코드',
			  name: 'prcsId',
			  align: 'center',
			  hidden: true
			  
			},
			
			{
			  header: '단계구분',
			  name: 'fg',
			  editor: {
				  type : 'select',
				  options : {
					  listItems: [
						  {text : '원자재', value :'STEP01'},
						  {text : '반제품', value :'STEP02'}
					  ]
				  }
			  },
			  
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
			  align: 'center',
			  editor: {
		            type: GelatoSelectEditor,
		            options: {
		            	listItems : [
		            		{text: '사용', value: 'Y'},
							{text: '비사용', value: 'N'}
		            		]
		            }
		      },
			  renderer: {
		            type: GelatoSelect,
		      }
			  
			}
		]
});
	
	// 추가 버튼 이벤트. 추가 버튼을 누르면 제품코드가 자동적으로 값이 들어가게 함.
	AddBtn.addEventListener("click", function(ev){
		 
		 console.log($('#prdtId').val());
		 
		 bomGrid.appendRow({prdtId:$('#prdtId').val()})
		
	});
	
	// 저장(등록) 버튼 이벤트. (alert 창 포함.)
	SaveBtn.addEventListener("click", function(){	
		bomGrid.request('modifyData');
		console.log("이거뭐양?" + bomGrid.getRow(0))
		
		if (bomGrid.getRow(0) != null) {
			bomGrid.blur();
		 if (confirm("저장하시겠습니까?")) {
			 bomGrid.request('modifyData',{
				showConfirm : false
			});
		  }
		} else {
			alert("선택된 데이터가 없습니다.");
		}
		
		flag = 'O'
	});
	
	//컨트롤러 응답
	bomGrid.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			bomGrid.readData(1);
			flag = 'X';
		}
		
	});
	
	// 모달창 생성 함수.
	$(function () {
		dialog = $( "#bomModal" ).dialog({
			autoOpen: false,
			height: 500,
			width: 700,
			modal: true
			
		})
	});
	
	// 제품 검색 버튼 이벤트.
	serachBtn.addEventListener("click", function() {
		
		console.log("제품검색 Modal")
		dialog.dialog( "open" );
		
		 // 컨트롤러에 보내주고 따로 모달은 jsp 만들 필요가 없으니깐  
		 $('#bomModal').load("${path}/com/bomModal.do",function () {
			 console.log('제품검색')
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
			//var useYn = document.getElementById("useYn").value;
			
			var useYn = $('input:checkbox[id="useYn"]').is(":checked") == true

			if (useYn == true) {
				useYn = "Y";
			} else {
				useYn = "N";
			} 
			
			console.log(prdtId);
			console.log(prdtNm);
			console.log(qy);
			console.log(vendName);
		
			
			
			bomGrid.readData(1, {'prdtId':prdtId, 'prdtNm':prdtNm, 'qy':qy, 'vendName':vendName, 'useYn':useYn }, true);
	});
	
	 // 그리드 셀 클릭하면 모달창 띄우기.
	function callRwmartCodeModal () {
		dialog = $("#rwmatrCodeModal").dialog({
			modal:true,
			autoOpen:false,
			height:400,
			width:600,
			modal:true
		});
		console.log("ppppp");
		dialog.dialog( "open" );
		console.log("dialog open확인");
		$("#rwmatrCodeModal").load("${path}/com/searchRwmatrCode.do", function(){console.log("자재코드 목록")})
	} 
	
	// 자재코드 셀 클릭시 모달
	bomGrid.on('click',(ev) => {
		rowkey = ev.rowKey;
		console.log(ev)
		console.log(ev.columnName)
		console.log(ev.rowKey)
		if (ev.columnName =='rwmatrId') {
			console.log('자재코드')
			callRwmartCodeModal ();
		}
	})
	// 모달창에서 자재코드를 선택하면 자재코드랑 자재 명 새로운 그리드 행에 들어가게 하기.
	function getRwmatrData(rwmatrData) {
		console.log("자재코드 모달 행 입력");
		
		bomGrid.setValue(rowkey, "rwmatrId", rwmatrData.rwmatrId, true)
		bomGrid.setValue(rowkey, "nm", rwmatrData.nm, true)
		
		dialog.dialog("close");
	}
	
	
	 // 그리드 사용공정 셀 클릭하면 모달창 띄우기.
	function callPrcsCodeModal () {
		dialog = $("#prcsCodeModal").dialog({
			modal:true,
			autoOpen:false,
			height:400,
			width:600,
			modal:true
		});
		console.log("iii");
		dialog.dialog( "open" );
		console.log("dialog open확인");
		$("#prcsCodeModal").load("${path}/com/searchPrcsCode.do", function(){console.log("공정코드 목록")})
	} 
	
	// 사용공정 셀 클릭시 모달 
	bomGrid.on('click',(ev) => {
		rowkey = ev.rowKey;
		console.log(ev)
		console.log(ev.columnName)
		console.log(ev.rowKey)
		if (ev.columnName == 'prcsNm') {
			console.log('공정명')
			callPrcsCodeModal ();
		}
	})
	
	// 모달창에서 공정코드를 선택하면 자재코드랑 자재 명 새로운 그리드 행에 들어가게 하기.
	function prcsCodeData(prcsData) {
		console.log("사용공정 코드 모달 행 입력");
		
		bomGrid.setValue(rowkey, "prcsNm", prcsData.prcsNm, true)
		bomGrid.setValue(rowkey, "prcsId", prcsData.prcsId, true)
		
		dialog.dialog("close");
	}
	

</script>		
		
		
</body>
</html>