<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>호텔 객실 예약 시스템 초안</title>
    <link rel= "stylesheet" href = "resources/form_table_style.css">
</head>
<body>

<h1>객실 예약</h1>

<form action="search.jsp" method="get">
	<div class = "form-elements">
	<div class = "form-element">
    체크인 날짜: <input type="date" name="checkin" required><br><br>
	</div>
	<div class = "form-element">
    체크아웃 날짜: <input type="date" name="checkout" required><br><br>
	</div>
	<div class = "form-element">
    인원수: <input type="number" name="person" min="1" required><br><br>
	</div>
	<div class = "form-element">
    객실 타입:
	    <select name="roomType">
	                <option value="">전체</option>
	                <option value="Standard">스탠다드</option>
	                <option value="Deluxe">디럭스</option>
	                <option value="Suite">스위트</option>
	                <option value="Royal Suite">로열 스위트</option>
	    </select><br>
    </div>
    <div class = "form-element">
    <input type="submit" value="객실 검색">
    </div>
   </div>
</form>

</body>
</html>
