<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<!-- 설비구분 모달 -->
	<div id="dialog-form" title="설비구분"></div>
		<div class="container col-sm-12" style="margin: 0px; width:100%;">
			<div>
				<h2 id="title">설비 등록</h2>
				<div class="search-area search-area-border grid-option-area">
					<div class="col-6 ml-1"></div>
					<div class="col-6 ta-r mr-1">
						<button type="reset" value="내용초기화" class="btn">초기화</button>
						<button class="btn">저장</button>
					</div>
				</div>
				<form action="${pageContext.request.contextPath}/eqm/insertEqm.do"
					method="post" name="frm" enctype="multipart/form-data">
					<br>
					<div class="grid-option-area">
						<div class="flex row">
							<div class="col-10">
								<table class="table table-bbs">
									<colgroup>
										<col style="width: 90px">
										<col style="width: 200px">
										<col style="width: 90px">
										<col style="width: 200px">
										<col style="width: 90px">
										<col style="width: 230px">
									</colgroup>
									<tbody>
										<tr class="height: 37px !important;">
											<th>설비명 *</th>
											<td><input id="eqmName" name="eqmName" required
												type="text"></td>
											<th>사용여부</th>
											<td><input type="radio" id="useYn" name="useYn"
												value="Y" checked>Y <input type="radio" id="notUse"
												name="useYn" value="N">N</td>
											<th>설비구분</th>
											<td><input id="fg" name="fg" required
												style="width: 50px;" type="text">
												<button id="btnFindFg" type="button" class="btn-modal"
													data-bs-toggle="modal" aria-label="Close"></button> <input
												type="text" id="fgName" name="fgName" style="width: 100px;"
												readonly></td>
										</tr>
										<tr>
											<th>설비규격</th>
											<td><input id="spec" name="spec" type="text"
												placeholder="ex)W*H*L"></td>
											<th>모델번호</th>
											<td><input id="modelNo" name="modelNo" type="text"></td>
											<th>제작업체</th>
											<td><input id="vendId" name="vendId" type="text"></td>
										</tr>
										<tr>
											<th>등록자</th>
											<td><input id="mngr" name="mngr" type="text"
												value="${loginVO.name }" disabled></td>
											<th>구매일자 *</th>
											<td><input type="date" id="pureDt" name="pureDt"
												required></td>
										</tr>
										<tr>
											<th>UPH *</th>
											<td><input id="uph" name="uph" required type="number"></td>
											<th>온도</th>
											<td colspan="3"><input placeholder="최저온도" id="tempMin"
												name="tempMin" style="width: 80px; margin-right: 5px;"
												type="number">~<input placeholder="최고온도"
												id="tempMax" name="tempMax"
												style="width: 80px; margin-left: 5px; margin-right: 5px;"
												type="number">°C</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="col-2" style="width: 670px;">
								<h5>설비 이미지 등록</h5>
								<div>
									<img style="width: 200px;" id="preview-image"
										src="../resources/images/img/이미지프리뷰.jpg">
								</div>

								<!-- egov 파일업로드 시작 -->

								<input name="file_1" id="egovComFileUploader" type="file"
									title="설비 이미지 업로드" multiple/>
								<div id="egovComFileList"></div>

								<!-- egov 파일 업로드 끝 -->
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>


	<script>
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        const reader = new FileReader()
	        // 이미지가 로드가 된 경우
	        reader.onload = e => {
	            const previewImage = document.getElementById("preview-image")
	            previewImage.src = e.target.result
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0])
			console.log(input.files[0]);
	    }
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("egovComFileUploader")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	})
	
	//설비구분 모달
	let dialog = $( "#dialog-form" ).dialog({
		autoOpen :false,
		modal : true
	});
	
	$("#btnFindFg").on("click",function(){
		
		dialog.dialog("open");
		$("#dialog-form").load("${path}/eqm/searchFgModal.do", 	//load가 익숙치 않으면 ajax를 써도됨
				function(){
			seolbiGrid.readData(1, {codeId:"EQM002"}, true);
			console.log("설비구분모달 로드됨")})
	});
	
	//uph유효성 검사
	/* var uph = $("#uph").val();
	if(uph != ''){
		if()
	} */

</script>
</body>
</html>