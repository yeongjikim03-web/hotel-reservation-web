<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link rel= "stylesheet" href = "resources/MyPage_style.css">
<title>마이페이지</title>

</head>

<body>

<%
    request.setCharacterEncoding("UTF-8");

    // 전달받은 고객 확인 정보
    String name = request.getParameter("name");
    String tel1 = request.getParameter("tel1");
    String tel2 = request.getParameter("tel2");
    String tel3 = request.getParameter("tel3");
    String phone_number = tel1 + "-" + tel2 + "-" + tel3;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int customer_id = -1; 
    String gender = "";
    String email = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=UTC&characterEncoding=UTF-8";
        conn = DriverManager.getConnection(url, "root", "root");

        // 고객 정보
        String sqlCustomer =
            "SELECT customer_id, name, gender, phone_number, email " +
            "FROM customer WHERE name=? AND phone_number=?";

        pstmt = conn.prepareStatement(sqlCustomer);
        pstmt.setString(1, name);
        pstmt.setString(2, phone_number);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
            out.println("<h2>일치하는 고객 정보를 찾을 수 없습니다.</h2>");
            out.println("<p>입력하신 이름과 전화번호를 다시 확인해주세요.</p>");
            return;
        }

        customer_id = rs.getInt("customer_id");
        gender = rs.getString("gender");
        email = rs.getString("email");

        rs.close();
        pstmt.close();

        // 고객 멤버십 정보
        String membership_grade = "없음";
        double point = 0;

        String sqlMembership =
            "SELECT membership_grade, point FROM membership WHERE customer_id=?";

        pstmt = conn.prepareStatement(sqlMembership);
        pstmt.setInt(1, customer_id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            membership_grade = rs.getString("membership_grade");
            point = rs.getDouble("point");
        }

        rs.close();
        pstmt.close();

        // 예약 내역 조회 쿼리
        String sqlReservation =
            "SELECT reservation_id, check_in, check_out, reservation_date, status, room_number " +
            "FROM reservation WHERE customer_id=? ORDER BY reservation_date DESC";

        pstmt = conn.prepareStatement(sqlReservation);
        pstmt.setInt(1, customer_id);
        rs = pstmt.executeQuery();

%>
	
	<!-- 고객 정보 -->
	<h2>고객 정보</h2>
	<div class = "info">
	<p>이름: <%= name %></p>
	<p>성별: <%= gender %></p>
	<p>전화번호: <%= phone_number %></p>
	<p>이메일: <%= email %></p>
	</div>
	
	<hr>
	
	<!-- 멤버십 정보 -->
	<h2>멤버십 정보</h2>
	<div class = "info">
	<p>멤버십 등급: <%= membership_grade %></p>
	<p>포인트: <%= point %></p>
	</div>
	
	<hr>
	
	<!-- 예약 내역 -->
	<h2>예약 내역</h2>

<%
    boolean hasReservation = false;
    while (rs.next()) {
        hasReservation = true;
%>

	<div class = "reservation">
	    <p><b>예약번호:</b> <%= rs.getInt("reservation_id") %></p>
	    <p><b>객실번호:</b> <%= rs.getInt("room_number") %></p>
	    <p><b>체크인:</b> <%= rs.getString("check_in") %></p>
	    <p><b>체크아웃:</b> <%= rs.getString("check_out") %></p>
	    <p><b>예약일:</b> <%= rs.getString("reservation_date") %></p>
	    <p><b>상태:</b> <%= rs.getString("status") %></p>
	</div>
    <% if (!rs.getString("status").equals("canceled")) { %>
    <form action="cancel_reservation.jsp" method="post" style="margin-top:10px;">
        <input id= "btn" type="hidden" name="reservation_id" value="<%= rs.getInt("reservation_id") %>">
        <input id = "btn" type="submit" value="예약 취소">
    </form>
    
    <% } else { %>
        <p style="color:red;">이미 취소된 예약입니다.</p>
    <% } %>
</div>


<%
    } // while end

    if (!hasReservation) {
%>
<p>예약 내역이 없습니다.</p>
<%
    }

    rs.close();
    pstmt.close();
    conn.close();

    } catch (Exception e) {
        out.println("<h3>오류 발생: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    }
%>

</body>
</html>
