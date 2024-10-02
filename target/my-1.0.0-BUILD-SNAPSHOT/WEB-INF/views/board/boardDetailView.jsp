<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	<!-- 게시글 -->
	<!-- Contact Section-->
        <section class="page-section masthead" id="contact">
            <div class="container">
                <!-- Contact Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">게시글</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Contact Section Form-->
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-xl-7">

                        	<div class="mb-3">
                        		<label>제목</label>
                        		<h6>${board.boardTitle }</h6>
                        	</div>
                        	<div class="mb-3">
                        		<label>작성자</label>
                        		<h6>${board.memNm }</h6>
                        	</div>
                        	<div class="mb-3">
                        		<label>수정일</label>
                        		<h6>${board.updateDt }</h6>
                        	</div>
                        	<div class="mb-3">
                        		<label>내용</label>
                        		<textarea class="form-control" style="height: 20rem" readonly>${board.boardContent }</textarea>
                        	</div>
                        	
                            <c:if test="${sessionScope.login.memId == board.memId }">
                            	<form action="<c:url value="/boardEditView" />" method="post" style="display: inline-block;" >
                            		<input type="hidden" name="boardNo" value="${board.boardNo }">
                            		<button class="btn btn-warning btn-xl" type="submit">수정</button>
                            	</form>
                            	<form action="<c:url value="/boardDeleteView" />" method="post" style="display: inline-block;">
                            		<input type="hidden" name="boardNo" value="${board.boardNo }">
                            		<button class="btn btn-danger btn-xl" type="submit">삭제</button>
                            	</form>
                            </c:if>
                    </div>
                </div>
                <!-- 댓글 작성 -->
                <div class="row justify-content-center pt-1">
                	<div class="col-lg-8 col-xl-7 d-flex">
                		<div class="col-lg-10">
                			<input type="text" id="replyInput" class="form-control">
                		</div>
                		<div class="col-lg-2">
                			<button type="button" onclick="fn_write()" class="btn btn-info me-2">등록</button>
                		</div>
                	</div>
                </div>
                <!-- 댓글 출력 -->
                <div class="row justify-content-center pt-1">
                	<div class="col-lg-8 col-xl-7">
                		<table class="table">
                			<tbody>
                				<c:forEach items="${replyList }" var="reply">
                					<tr id="${reply.replyNo }">
                						<td>${reply.replyNo }</td>
                						<td>${reply.replyContent }</td>
                						<td>${reply.memNm }</td>
                						<td>${reply.replyDate }</td>
                					</tr>
                				</c:forEach>
                			</tbody>
                		</table>
                	</div>
                </div>
            </div>
        </section>
	<script type="text/javascript">
		function fn_write(){
			let memId = '${sessionScope.login.memId}';
			let boardNo = '${board.boardNo};'
			let msg = $("#replyInput").val();
			if(memId == ''){
				alert("댓글은 로그인 해야함!!!");
				return;
			}
			if(msg == ''){
				alert("내용을 작성해 주세요.");
				return;
			}
			let sendData = JSON.stringify({
				  memId:memId
				, boardNo:boardNo
				, replyContent:msg
			});
			console.log(sendData);
			$.ajax({
				 url : '<c:url value="/writeReplyDo" />'
				,type : 'POST'
				,contentType : 'application/json'
				,dataType : 'json'
				,data : sendData
				,success:function(res){
					console.log('응답');
					console.log(res);
				}
				,error : function(e){
					console.log(e);
				}
			});
		}
	</script>
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

</body>
</html>