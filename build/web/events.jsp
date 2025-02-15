<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Event" %>
<!DOCTYPE html>
<html>
<head>
    <title>Event Listings</title>
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

    <div class="container">
        <h2>Upcoming Events</h2>

<!-- Filter Form -->
<form action="events" method="GET" class="filter-form">
    <input type="text" name="keyword" placeholder="Search by name or location" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
    
    <select name="type">
        <option value="">All Types</option>
        <option value="Conference" <%= "Conference".equals(request.getParameter("type")) ? "selected" : "" %>>Conference</option>
        <option value="Wedding" <%= "Wedding".equals(request.getParameter("type")) ? "selected" : "" %>>Wedding</option>
        <option value="Workshop" <%= "Workshop".equals(request.getParameter("type")) ? "selected" : "" %>>Workshop</option>
        <option value="Party" <%= "Party".equals(request.getParameter("type")) ? "selected" : "" %>>Party</option>
    </select>
    
    <input type="date" name="date" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">
    
    <button type="submit">Filter</button>
</form>


        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Date</th>
                    <th>Location</th>
                    <th>Type</th>
                    <th>Description</th>
                    <th>Actions</th> <!-- New column for actions -->
                </tr>
            </thead>
            <tbody>
                <%
                    List<Event> events = (List<Event>) request.getAttribute("events");
                    if (events != null && !events.isEmpty()) {
                        for (Event event : events) {
                %>
                <tr>
                    <td><%= event.getName() %></td>
                    <td><%= event.getDate() %></td>
                    <td><%= event.getLocation() %></td>
                    <td><%= event.getType() %></td>
                    <td><%= event.getDescription() %></td>
                    <td>
                        <a href="EditEventServlet?id=<%= event.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="DeleteEventServlet?id=<%= event.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this event?')">Delete</a>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr><td colspan="6">No events found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
