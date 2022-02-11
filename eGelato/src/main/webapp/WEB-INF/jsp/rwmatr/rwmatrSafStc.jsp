<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안전재고 관리</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
<h2>안전재고 관리</h2>
<div>
	<div>
		<form action="">
		    <table>
		        <tbody>
		            <tr>
		                <th>자재명</th>
		                <td>
		                	<input type="text" id="rwmName"><button type="button" id="rwmNameM" class="btn-modal"></button>
		                	<input type="text" id="rwmId" readOnly>
		                </td>
		            </tr>
		            <tr>
		                <th>업체명</th>
		                <td>
		                	<input type="text" id="vendName"><button type="button" id="vendNameM" class="btn-modal"></button>
		                	<input type="text" id="vendId" readOnly>
		                </td>
		                <td><button type="button" id="btnFind">조회</button></td>
		                <td><button type="reset">초기화</button></td>
		            </tr>
		        </tbody>
		    </table>
	    </form>
	</div>
</div>
<hr>
<br>
<div class="row">
	<!-- 안전재고 그리드 -->
	<div class="col-4">
		<div id="rwmatrSafStcGrid"></div>
	</div>
	<div class="col-8">
		<div id="rwmatrUphGrid"></div>
		<div id="totalQy" style="float: right; font-size: 24px;"></div>
		<h2>상세조회</h2>
			<form>
				<table>
					<tbody>
						<tr>
							<th>자재코드</th>
							<td><input id="rwmatrId" name="rwmatrId" type="text" readOnly></td>
							
						</tr>
						<tr>
							<th>자재명</th>
							<td><input id="nm" name="nm" type="text" readOnly></td>
						</tr>
						<tr>
							<th>안전재고</th>
							<td><input id="safStc" name="safStc" type="text"></td>
						</tr>
						<tr>
							<td><button type="button" id="btnUpd">수정</button></td>
							<td><button type="reset">초기화</button></td>
						</tr>
					</tbody>
				</table>
			</form>
	</div>
</div>
	
	<!-- 모달창 -->
	<div id="rwmatrDialogFrm" title="원자재 목록"></div>
	<div id="vendDialogFrm" title="업체 목록"></div>

<script>
var Grid = tui.Grid;

//검색조건
var rwmName;
var vendName;

var rwmatrId;

var rk;

document.getElementById("btnFind").addEventListener("click", function () {
	rwmName = document.getElementById("rwmName").value;
	vendName = document.getElementById("vendName").value;
	
	rwmatrSafStcGrid.readData(1,{'rwmName':rwmName,
								 'vendName':vendName}, true);
});

toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
	}
	
// 그리드 생성
var rwmatrSafStcGrid = new Grid({
	el: document.getElementById('rwmatrSafStcGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrSafStcList.do', method: 'GET'},
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	bodyHeight: 580,
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '자재코드',
		    name: 'rwmatrId',
		    sortable: true
		  },
		  {
		    header: '자재명',
		    name: 'nm',
		    sortable: true
		  },
		  {
		    header: '업체명',
		    name: 'vendName',
		    sortable: true
		  },
		  {
		    header: '규격',
		    align: 'right',
		    name: 'spec',
		    sortable: true
		  },
		  {
		    header: '작업단위',
		    align: 'right',
		    name: 'wkUnit',
	    	formatter({value}) { // 추가
			  let a = `\${value}`
		  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
		      return b;
		    },
		    sortable: true
		  },
		  {
		    header: '안전재고',
		    align: 'right',
		    name: 'safStc',
	    	formatter({value}) { // 추가
			  let a = `\${value}`
		  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
		      return b;
		    },
		    sortable: true
		  }
		]
});

//그리드 생성
var rwmatrUphGrid = new Grid({
	el: document.getElementById('rwmatrUphGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrUphList.do', method: 'GET'},
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum','checkbox'],
  	bodyHeight: 300,
  	selectionUnit: 'row',
  	columns:[
		  {
		    header: 'BOM코드',
		    name: 'bomId',
		    sortable: true
		  },
		  {
		    header: '제품코드',
		    name: 'prdtId',
		    sortable: true
		  },
		  {
		    header: '제품명',
		    name: 'prdtNm',
		    sortable: true
		  },
		  {
		    header: '공정코드',
		    name: 'prcsId',
		    sortable: true
		  },
		  {
		    header: '공정명',
		    name: 'prcsNm',
		    sortable: true
		  },
		  {
		    header: '설비코드',
		    name: 'eqmId',
		    sortable: true
		  },
		  {
		    header: '설비명',
		    name: 'eqmName',
		    sortable: true
		  },
		  {
		    header: '소모량',
		    name: 'qy',
		    align: 'right',
		    formatter({value}) {
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			  	  if(b == 'null'){
					return '';  
				  } else {
			        return b;
				  }
			    },
		    sortable: true
		  },
		  {
		    header: 'UPH',
		    name: 'uph',
		    align: 'right',
		    formatter({value}) {
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			  	  if(b == 'null'){
					return '';  
				  } else {
			        return b;
				  }
			    },
		    sortable: true
		  },
		  {
		    header: '총소모량',
		    name: 'total',
		    align: 'right',
		    formatter({value}) {
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			  	  if(b == 'null'){
					return '';  
				  } else {
			        return b;
				  }
			    },
		    sortable: true
		  }
		]
});

rwmatrSafStcGrid.on('click', (ev) => {	
	rk = ev.rowKey;
	console.log(ev)
	//cell 선택시 row 선택됨.
	rwmatrSafStcGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, rwmatrSafStcGrid.getColumns().length-1]
	  });
	
	//클릭한 row의 orderId에 해당하는 code를 읽어옴
	rwmatrId = rwmatrSafStcGrid.getRow(ev.rowKey).rwmatrId;
	rwmatrUphGrid.readData(1, {'rwmatrId':rwmatrId}, true);
	
	$("#rwmatrId").val(rwmatrSafStcGrid.getRow(ev.rowKey).rwmatrId);
	$("#nm").val(rwmatrSafStcGrid.getRow(ev.rowKey).nm);
	$("#safStc").val(rwmatrSafStcGrid.getRow(ev.rowKey).safStc);
	
});

rwmatrUphGrid.on('check', (ev) => {
	
	let sumQy = 0;
	let stc = rwmatrUphGrid.getCheckedRows();
	
	for(s of stc){
		sumQy += parseInt(s.total);
	}
	
	$("#totalQy").html("총 소모량 : " + sumQy)
	
});

rwmatrUphGrid.on('uncheck', (ev) => {
	
	let sumQy = 0;
	let stc = rwmatrUphGrid.getCheckedRows();
	
	for(s of stc){
		sumQy += parseInt(s.total);
	}
	
	$("#totalQy").html("총 소모량 : " + sumQy)
	
});

//자재모달
let rwmatrDialogFrm = $( "#rwmatrDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 550,
      width: 600,
      modal: true
});

function callRwmatrModal(){
	
    rwmatrDialogFrm.dialog( "open" );
    $("#rwmatrDialogFrm").load("${path}/rwmatr/searchRwmatrDialog.do", function(){console.log("원자재 목록")})
}
 
//업체명 모달
let vendDialogFrm = $( "#vendDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 500,
      width: 600,
      modal: true
});

function callVendModal(){

    vendDialogFrm.dialog( "open" );
    $("#vendDialogFrm").load("${path}/rwmatr/searchVendDialog.do", function(){console.log("업체명 목록")})
}

	//모달에서 텍스트박스로
	function getRwmatrData(rwmatrData) {
		console.log("입고정보 기입")
		document.getElementById("rwmName").value = rwmatrData.nm;
		document.getElementById("rwmId").value = rwmatrData.rwmatrId;
		
		rwmatrDialogFrm.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmNameM").addEventListener("click", function() {
		  callRwmatrModal();
	});
	
	//업체리스트 모달에서 받아온 텍스트박스에 넣어줌
	function getVendData(vendData) {
		document.getElementById("vendName").value = vendData.vendName;
		document.getElementById("vendId").value = vendData.vendId;
		
		vendDialogFrm.dialog( "close" );
	}
	
	//업체명 textbox
	document.getElementById("vendNameM").addEventListener("click", function() {
		callVendModal();
	});
	
	//안전재고 수정
	btnUpd.addEventListener("click", function(){
		let rwmatrId = $("#rwmatrId").val();
		let safStc = $("#safStc").val();
		//let rwmatr = frm.serialize();
		
		if(rwmatrId == ''){
			toastr.clear()
			toastr.warning( ('자재를 선택하세요.'),'Gelato',{timeOut:'1800'} );
		} else{
			if (confirm("수정하시겠습니까?")) {
				$.ajax({
					url : "${path}/rwmatr/rwmatrModifyData.do",
					type:'POST',
					dataType: "json",
					data: {"rwmatrId": rwmatrId,
							"safStc" : safStc},
					error : function(result) {
						toastr.clear()
						toastr.error( ('알 수 없는 오류가 발생하였습니다.'),'Gelato',{timeOut:'1800'} );
					}
				}).done(function (result) {
					console.log(result);
					rwmatrSafStcGrid.setValue(rk, "safStc", safStc, true);
					toastr.clear()
					toastr.success( ('수정되었습니다.'),'Gelato',{timeOut:'1800'} );
				})
			}
		}
		
	});
	
</script>
</body>
</html>