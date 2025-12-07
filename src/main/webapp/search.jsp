<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>객실 검색 결과</title>
    <link rel= "stylesheet" href = "resources/form_table_style.css">
</head>
<body>

<h2>객실 검색 결과</h2>

<%
    request.setCharacterEncoding("UTF-8");

    String checkin = request.getParameter("checkin");
    String checkout = request.getParameter("checkout");
    int person = Integer.parseInt(request.getParameter("person"));
    String grade = request.getParameter("roomType");
    		
    		
    // mysql db 연결 (보낸 링크 참고 했습니다. 이 부분 틀렸으면 알려주세요.)
    // 만약 3307 이면 url 부분 변경하시면 됩니다
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=UTC&characterEncoding=UTF-8";
    
    //마지막 파라미터에 root 비밀번호 넣으면 됩니다!!! 다들 비밀번호 root 로 설정하셨을 거에요. 
    //아니시라면 비밀번호 변경해주세요~
    Connection conn = DriverManager.getConnection(url, "root", "root");  

    // 쿼리 작성해서 string 속성에 저장하기. .. .
	String sql =
    "SELECT r.room_number, r.price, rt.grade, rt.bed_type, rt.capacity " +
    "FROM room r " +
    "JOIN room_type rt ON r.type_id = rt.type_id " +
    "WHERE r.is_available = 1 " +
    "AND rt.capacity >= ? " +
    "AND r.room_number NOT IN ( " +
    "    SELECT room_number FROM reservation " +
    "    WHERE (check_in < ? AND check_out > ?) " +
    ") ";


     if (grade != null && !grade.equals("")) {
        sql += "AND rt.grade = ? ";
    }
   

    PreparedStatement pstmt = conn.prepareStatement(sql);

    pstmt.setInt(1, person); 
    pstmt.setString(2, checkout); 
    pstmt.setString(3, checkin);  

    if (grade != null && !grade.equals("")) {
        pstmt.setString(4, grade);
    }

    ResultSet rs = pstmt.executeQuery();
%>

<table border="1">
<thead>
    <tr>
        <th>객실 번호</th>
        <th>등급(Grade)</th>
        <th>침대 종류</th>
        <th>최대 인원</th>
        <th>가격</th>
        <th>예약하기</th>
    </tr>
    </thead>

<%
    boolean hasRoom = false;
    while (rs.next()) {
        hasRoom = true;
%>
    <tr>
        <td><%= rs.getInt("room_number") %></td>
        <td><%= rs.getString("grade") %></td>
        <td><%= rs.getString("bed_type") %></td>
        <td><%= rs.getInt("capacity") %></td>
        <td><%= rs.getBigDecimal("price") %>만원</td>
        
        <td>
        	<form action = "reserve_customer_input.jsp" method = "post">
        		<input type = "hidden" name = "room_number" value = "<%= rs.getInt("room_number")  %>" >
        		<input type = "hidden" name = "checkin" value = "<%= request.getParameter("checkin") %>">
        		<input type = "hidden" name = "checkout" value = "<%= request.getParameter("checkout") %>">
        		<input type = "hidden" name = "person" value = "<%= request.getParameter("person") %>">
        		<input type = "hidden" name = "roomType" value = "<%= rs.getString("grade") %>"> 
        		        		
        		<input class = "tbButton" type = "submit" value = "예약하기">
            </form>
        </td>
        
    </tr>
<%
    }

    rs.close();
    pstmt.close();
    conn.close();
%>

</table>

<%
    if (!hasRoom) {
%>
    <p>조건에 맞는 객실이 없습니다.</p>
<%
    }
%>

<br><br>
<a href="mainhome.jsp"> 홈화면으로 돌아가기</a>

</body>
</html>

