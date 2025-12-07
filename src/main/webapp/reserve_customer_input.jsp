<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 고객 정보 입력</title>
<link rel= "stylesheet" href = "resources/form_table_style.css">
</head>

<body>

	<h2>예약 정보 확인</h2>
	<p>아래 예약 정보를 확인한 후, 고객 정보를 입력해주세요.</p>

<%
    // search.jsp에서 넘어온 예약 정보(방 정보)
    String roomNum = request.getParameter("room_number");
    String checkin = request.getParameter("checkin");
    String checkout = request.getParameter("checkout");
    String person = request.getParameter("person");
    String roomType = request.getParameter("roomType");
%>

	<!-- 사용자가 확인할 수 있도록 
		사용자가 이전에 선택한 방 내용을 출력하게 했습니다.  -->
	<p><strong>객실 번호:</strong> <%= roomNum %></p>
	<p><strong>객실 타입:</strong> <%= roomType %></p>
	<p><strong>체크인:</strong> <%= checkin %></p>
	<p><strong>체크아웃:</strong> <%= checkout %></p>
	<p><strong>인원 수:</strong> <%= person %>명</p>
	
	<br><hr><br>
	
	<h2>고객 정보 입력</h2>
	
	<form id ="custinput" action="customer_info_process.jsp" method="post">
	
	    
	    <input type="hidden" name="room_number" value="<%= roomNum %>">
	    <input type="hidden" name="roomType" value="<%= roomType %>">
	    <input type="hidden" name="checkin" value="<%= checkin %>">
	    <input type="hidden" name="checkout" value="<%= checkout %>">
	    <input type="hidden" name="person" value="<%= person %>">

	    이름
	    <br>
	    <input type="text" name="name" required><br><br>

	    성별
	    <br>
	    <!-- 기타 성별 추가했습니다 . -->
	    <select name="gender" required>
	        <option value="M">남성</option>
	        <option value="F">여성</option>
	        <option value="O">기타</option>
	    </select><br><br>

	    전화번호<br>
	    <input type="text" name="tel1" maxlength="3" placeholder="010" required> -
	    <input type="text" name="tel2" maxlength="4" placeholder="1234" required> -
	    <input type="text" name="tel3" maxlength="4" placeholder="5678" required><br><br>
	    이메일
	    <input type="text" name="email" placeholder="example@mail.com" required><br><br> 
        <input type="submit" value="예약 완료">

	</form>

</body>
</html>
