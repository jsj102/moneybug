<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <c:forEach items="${tagreplylist}" var="tagReplyDTO">
				<c:if test="${tagReplyDTO.replyLevel eq 0}">
					<div class="tagreply original-reply">
						<br> ${tagReplyDTO.writerId} <br> ${tagReplyDTO.content}

						<br>
						<p style="font-size: 12px;">
							<fmt:formatDate value="${tagReplyDTO.createAt}"
								pattern="yyyy-MM-dd HH:mm" />
						</p>

						<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
						<c:choose>
							<c:when test="${sessionScope.userNickname eq tagReplyDTO.writerId }">
								<button class="re-tagreply" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">답글</button>
								<button class="tagreplyupdate" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">수정</button>
								<button class="tagreplydelete" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">삭제</button>
							</c:when>
							<c:otherwise>
								<button class="re-tagreply" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">답글</button>
								
							</c:otherwise>
						</c:choose>


						<form name="form" class="tagreply-update-form"
							selected_id="${tagReplyDTO.seq}">
							<textarea id="updatecontent${tagReplyDTO.seq}">${tagReplyDTO.content}</textarea>
							<button type="submit" style="background: grey; color: white;">수정</button>
						</form>



						<form name="form" class="re-tagreply-form"
							selected_id="${tagReplyDTO.seq}">
							<textarea id="reinsertcontent${tagReplyDTO.seq}"></textarea>
							<button type="submit" style="background: grey; color: white;">등록</button>
						</form>
						<br>
					</div>

					<!-- 대댓글 표시 -->
					<div>
						<c:forEach items="${tagreplylist}" var="reply">
							<c:if
								test="${reply.replyLevel eq 1 and reply.groupSeq eq tagReplyDTO.groupSeq}">
								<div class="tagreply indented-reply" style="margin-left: 20px;">
									<br> ${reply.writerId} <br> ${reply.content} <br>
									<p style="font-size: 12px;">
										<fmt:formatDate value="${reply.createAt}"
											pattern="yyyy-MM-dd HH:mm" />
									</p>

									<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
									<c:choose>
										<c:when test="${sessionScope.userNickname eq reply.writerId }">
											<button class="re-tagreply" selected_id="${reply.seq}"
												style="background: grey; color: white;">답글</button>
											<button class="tagreplyupdate" selected_id="${reply.seq}"
												style="background: grey; color: white;">수정</button>
											<button class="tagreplydelete" selected_id="${reply.seq}"
												style="background: grey; color: white;">삭제</button>
										</c:when>
										<c:otherwise>
											<button class="re-tagreply" selected_id="${reply.seq}"
												style="background: grey; color: white;">답글</button>
											
										</c:otherwise>
									</c:choose>

									<form name="form" class="tagreply-update-form"
										selected_id="${reply.seq}">
										<textarea id="updatecontent${reply.seq}">${reply.content}</textarea>
										<button type="submit" style="background: grey; color: white;">수정</button>
									</form>



									<form name="form" class="re-tagreply-form"
										selected_id="${reply.seq}">
										<textarea id="reinsertcontent${reply.seq}"></textarea>
										<button type="submit" style="background: grey; color: white;">등록</button>
									</form>
									<br>

								</div>



							</c:if>
						</c:forEach>
					</div>





				</c:if>
			</c:forEach>