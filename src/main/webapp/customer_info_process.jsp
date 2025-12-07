<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>예약 처리</title>

</head>

<body>
<%
	
	// Post 로 넘어온 한글 안 깨지게 하려고 넣었습니다.
	request.setCharacterEncoding("UTF-8");
	
	String room_number = request.getParameter("room_number");
	String checkin = request.getParameter("checkin");
	String checkout = request.getParameter("checkout");
	String person = request.getParameter("person");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");
	String phone_number = tel1 + "-" + tel2 + "-" + tel3;
	String email = request.getParameter("email");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=UTC&characterEncoding=UTF-8";
	Connection conn = DriverManager.getConnection(url, "root", "root");
	
	try {
	
	    
	    String customerInsert =
	        "INSERT INTO customer (name, gender, phone_number, email) VALUES (?, ?, ?, ?)";
	    
	    PreparedStatement pstmt1 = conn.prepareStatement(customerInsert, Statement.RETURN_GENERATED_KEYS);
	
	    pstmt1.setString(1, name);
	    pstmt1.setString(2, gender);
	    pstmt1.setString(3, phone_number);
	    pstmt1.setString(4, email);
	    pstmt1.executeUpdate();
	
	    // 생성된 customer_id 가져오기
	    int customer_id = 0;
	    ResultSet custKey = pstmt1.getGeneratedKeys();
	    if (custKey.next()) {
	        customer_id = custKey.getInt(1);
	    } else {
	        out.println("<h3>고객 아이디 생성 실패</h3>");
	        return;
	    }
	    custKey.close();
	    pstmt1.close();
	
	
	    // 예약 정보 쿼리 보시고 오류 있으면 알려주세요. 
	    String reservationInsert =
	        "INSERT INTO reservation (check_in, check_out, reservation_date, status, customer_id, room_number) "
	        + "VALUES (?, ?, NOW(), 'reserved', ?, ?)";
	
	    PreparedStatement pstmt2 = conn.prepareStatement(reservationInsert);
	    pstmt2.setString(1, checkin);
	    pstmt2.setString(2, checkout);
	    pstmt2.setInt(3, customer_id);
	    pstmt2.setString(4, room_number);
	    pstmt2.executeUpdate();
	    pstmt2.close();
	
	
	    // 예약 시에 방 상태(0, 1) 변경하는 구문입니다. 오류 있으면 알려주세요.
	    // 테스트 시에는 잘 됐는데 혹시 모르니 다시 테스트 부탁드립니다.
	    String updateRoom = "UPDATE room SET is_available = 0 WHERE room_number = ?";
	    
	    PreparedStatement pstmtRoom = conn.prepareStatement(updateRoom);
	    pstmtRoom.setString(1, room_number);
	    pstmtRoom.executeUpdate();
	    pstmtRoom.close();
	
	
	    // 멤버십 확인 후 없으면 생성하는 부분입니다 . 
	    // 처음은 실버, 1포인트로 시작하게 했습니다.
	    String checkMem = "SELECT * FROM membership WHERE customer_id = ?";
	    
	    PreparedStatement check = conn.prepareStatement(checkMem);
	    check.setInt(1, customer_id);
	    ResultSet mem = check.executeQuery();
	
	    if (!mem.next()) {
	        
	        String memInsert =
	            "INSERT INTO membership (membership_grade, point, customer_id) VALUES ('silver', 1, ?)";
	        
	        PreparedStatement pstmt3 = conn.prepareStatement(memInsert);
	        pstmt3.setInt(1, customer_id);
	        pstmt3.executeUpdate();
	        pstmt3.close();
	    }
	    
	    mem.close();
	    check.close();
	
	
	    // 웹페이지 사용자에게 보이는 곳입니다.
	    out.println("<h2>예약이 완료되었습니다!</h2>");
	    out.println("<p>예약자: " + name + "</p>");
	    out.println("<p>객실 번호: " + room_number + "</p>");
	    out.println("<p>체크인: " + checkin + "</p>");
	    out.println("<p>체크아웃: " + checkout + "</p>");
	
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    conn.close();
	}

%>

<a href="mainhome.jsp"> 홈화면으로 돌아가기</a>
</body>
</html>
