<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.CommentBean"%>
<%@page import="board.CommentDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   
 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="notice.jsp">공지사항</a></li>
<li><a href="fnotice.jsp">자료실</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<%
int re_ref=Integer.parseInt(request.getParameter("re_ref"));
int re_lev=Integer.parseInt(request.getParameter("re_lev"));
int re_seq=Integer.parseInt(request.getParameter("re_seq"));
// num , pageNum 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");
//BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// 조회수 증가
// updateReadcount(num)
bdao.updateReadcount(num);
//BoardBean bb  =  getBoard(num) 메서드호출
BoardBean bb=bdao.getBoard(num);
String content=bb.getContent();
if(content!=null){
	//   /r/n => <br> 바꾸기   문자열.replace("old문자열","new문자열")
	content=content.replace("\r\n","<br>");		
}
%>
<article>
<h1>Rewrite_File Content</h1>
<form action="reWritePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="re_ref" value="<%=re_ref%>">
<input type="hidden" name="re_lev" value="<%=re_lev%>">
<input type="hidden" name="re_seq" value="<%=re_seq%>">
<table id="notice">
<tr><td class="twrite">작성자</td><td><input type="text" name="name"></td></tr>
<tr><td class="twrite">비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td class="twrite">제목</td><td colspan="3"><input type="text" name="subject" value="[re]"></td></tr>
<tr><td class="twrite">내용</td><td><textarea name="content" rows="10" cols="20"></textarea></tr>

<%
if(bb.getFile()!=null){
	// 교재 302페이지
	%>
	<tr><td>첨부파일</td><td colspan="3"><a href="file_down.jsp?file_name=<%=bb.getFile()%>"><%=bb.getFile() %></a>
	
	<%
	if(bb.getFile().contains(".jpg")||bb.getFile().contains(".png")||bb.getFile().contains(".jpeg")||bb.getFile().contains(".gif")){
	%>
	<img src="../upload/<%=bb.getFile() %>" width="200"	 height="200">
	<%
	} 
	%>
	
	</td></tr>
<%
}
%>
</table>
<div id="table_search">
<%
String id = (String)session.getAttribute("id");
if(id!=null){
	if(id.equals(bb.getName())){
	%>
	<input type="button" value="글수정" class="btn" 
 	onclick="location.href='fupdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
 	<input type="button" value="글삭제" class="btn" 
	 onclick="del()">
	<%	
	}
}
%>
<script type="text/javascript">
function del(){
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	     location.href="deletePro.jsp?num=<%=num %>&pageNum=<%=pageNum %>";
	 }else{   //취소
	     return false;
	 }
}
function commcheck(){
	if(document.comm1.content.value=="(150자)"){
		alert("내용을 입력해주세요!")
		document.comm1.content.focus();
		document.comm1.content.select();
		return false;
	}
}
</script>
<input type="submit" value="글쓰기" class="btn">
<input type="button" value="글목록" class="btn" 
 onclick="location.href='fnotice.jsp?pageNum=<%=pageNum%>'">
</div>
<div class="clear"></div>


 </form>
</article>




<div id="page_control">
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>