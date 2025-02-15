<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<%
    // Check if the user is logged in
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Event Management System</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About Us</a>
        <a href="add_event.jsp">Add Event</a>
        <a href="events">Manage Events</a>
        <a href="logout.jsp" style="float:right;">Logout</a>
    </div>

    <!-- Header -->
    <div class="header">
        <h1>Welcome, <%= user %>!</h1>
        <p>Plan, manage, and attend events easily!</p>
    </div>

    <!-- Main Content -->
    <div class="container">
        <h2>Upcoming Events</h2>

        <% 
            String jdbcUrl = "jdbc:mysql://localhost:3306/event_db";
            String jdbcUser = "root";
            String jdbcPassword = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM events ORDER BY date ASC LIMIT 5");
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
        %>
            <div class="event-card">
                <h3><%= rs.getString("name") %></h3>
                <p><strong>Date:</strong> <%= rs.getString("date") %></p>
                <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                <p><strong>Type:</strong> <%= rs.getString("type") %></p>
                <p><%= rs.getString("description") %></p>
                <!-- FIXED: Corrected event_id passing in URL -->
                <a href="event_details.jsp?event_id=<%= rs.getInt("id") %>" class="btn">View Details</a>
            </div>
        <% 
                }
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Event Manager. All Rights Reserved.</p>
    </div>
</body>
</html>
