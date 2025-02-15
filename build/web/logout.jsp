<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Destroy the session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
