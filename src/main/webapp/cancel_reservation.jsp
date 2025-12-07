<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>예약 취소</title>

</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String reservationId = request.getParameter("reservation_id");
	
	Connection conn = null;
	
	try {
		
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection(
	        "jdbc:mysql://localhost:3306/hotel?serverTimezone=UTC&characterEncoding=UTF-8",
	        "root", "root");
	
	
	    
	    String sql = "UPDATE reservation SET status = 'canceled' WHERE reservation_id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, Integer.parseInt(reservationId));
	    pstmt.executeUpdate();
	    pstmt.close();
	
	
	    
	    String roomSql = "SELECT room_number FROM reservation WHERE reservation_id = ?";
	    PreparedStatement pstmtRoom = conn.prepareStatement(roomSql);
	    pstmtRoom.setInt(1, Integer.parseInt(reservationId));
	    ResultSet rs = pstmtRoom.executeQuery();
	
	    int roomNumber = 0;
	    
	    if (rs.next()) {
	        roomNumber = rs.getInt("room_number");
	    }
	    
	    rs.close();
	    pstmtRoom.close();
	
	
	    
	    String updateRoom = "UPDATE room SET is_available = 1 WHERE room_number = ?";
	    PreparedStatement pstmtUpdate = conn.prepareStatement(updateRoom);
	    pstmtUpdate.setInt(1, roomNumber);
	    pstmtUpdate.executeUpdate();
	    pstmtUpdate.close();
	
	
	    
	    out.println("<h2>예약이 성공적으로 취소되었습니다.</h2>");
	    out.println("<p>예약 번호: " + reservationId + "</p>");
	    out.println("<a href='mypage_customer_input.jsp'>마이페이지로 돌아가기</a>");
	
	} catch (Exception e) {
	    out.println("<h3>오류 발생: " + e.getMessage() + "</h3>");
	} finally {
	    try { if (conn != null) conn.close(); } catch (Exception e) {}
	}

%>

</body>
</html>
