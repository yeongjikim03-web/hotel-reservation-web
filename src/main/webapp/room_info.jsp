<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<link rel= "stylesheet" href = "resources/form_table_style.css">
<title>객실 소개</title>

</head>

<body>
	
	<h2>객실 소개</h2>
	<p>호텔의 모든 객실 정보를 확인하실 수 있습니다.</p>

<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
	    "jdbc:mysql://localhost:3306/hotel?serverTimezone=UTC&characterEncoding=UTF-8",
	    "root", "root"
	);
	
	String sql =
	    "SELECT r.room_number, r.price, r.is_available, " +
	    "t.grade, t.bed_type, t.capacity " +
	    "FROM room r JOIN room_type t ON r.type_id = t.type_id " +
	    "ORDER BY r.room_number";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>

	<table border="1" cellpadding="8" cellspacing="0">
	<thead>
	    <tr>
	        <th>객실 번호</th>
	        <th>등급</th>
	        <th>침대 타입</th>
	        <th>수용 인원</th>
	        <th>가격</th>
	        <th>예약 가능 여부</th>
	    </tr>
   </thead>

<%
	while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("room_number") %></td>
        <td><%= rs.getString("grade") %></td>
        <td><%= rs.getString("bed_type") %></td>
        <td><%= rs.getInt("capacity") %> 명</td>
        <td><%= rs.getInt("price") %> 만원</td>
        <td>
            <%= rs.getInt("is_available") == 1 ? "예약 가능" : "예약 불가" %>
        </td>
    </tr>
<%
	}
	rs.close();
	pstmt.close();
	conn.close();
%>
	
	</table>
	
	<br>
	<a href="mainhome.jsp"> 홈화면으로 돌아가기</a>

</body>

</html>
