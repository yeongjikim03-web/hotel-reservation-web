<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>마이페이지 고객 정보 입력</title>
<link rel= "stylesheet" href = "resources/form_table_style.css">
</head>

<body>

<h2>마이페이지 조회</h2>
<p id = "etc">개인정보 및 예약 내역을 조회하려면 고객 정보를 입력해주세요.</p>

<form id = "custinput" action="MyPage.jsp" method="post">

    이름<br>
    <input type="text" name="name" required>

    <p>전화번호<br>
    <input type="text" name="tel1" placeholder="010" maxlength="3" required> -
    <input type="text" name="tel2" placeholder="1234" maxlength="4" required> -
    <input type="text" name="tel3" placeholder="5678" maxlength="4" required><br><br>

    <input type="submit" value="조회하기">

</form>

</body>
</html>
