<%@ page import="models.Event" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Event</title>
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
        <h2>Edit Event</h2>

        <%
            Event event = (Event) request.getAttribute("event");
            if (event != null) {
        %>

        <form action="UpdateEventServlet" method="post" class="event-form">
            <input type="hidden" name="id" value="<%= event.getId() %>">

            <div class="form-group">
                <label for="name">Event Name</label>
                <input type="text" id="name" name="name" class="input-field" value="<%= event.getName() %>" required>
            </div>

            <div class="form-group">
                <label for="date">Date</label>
                <input type="date" id="date" name="date" class="input-field" value="<%= event.getDate() %>" required>
            </div>

            <div class="form-group">
                <label for="location">Location</label>
                <input type="text" id="location" name="location" class="input-field" value="<%= event.getLocation() %>" required>
            </div>

            <div class="form-group">
                <label for="type">Type</label>
                <select id="type" name="type" class="input-field">
                    <option value="Conference" <%= "Conference".equals(event.getType()) ? "selected" : "" %>>Conference</option>
                    <option value="Wedding" <%= "Wedding".equals(event.getType()) ? "selected" : "" %>>Wedding</option>
                    <option value="Workshop" <%= "Workshop".equals(event.getType()) ? "selected" : "" %>>Workshop</option>
                    <option value="Party" <%= "Party".equals(event.getType()) ? "selected" : "" %>>Party</option>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="input-field" required><%= event.getDescription() %></textarea>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-primary">Update Event</button>
                <a href="events" class="btn">Cancel</a>
            </div>
        </form>

        <% } else { %>
            <div class="alert">Event not found!</div>
        <% } %>

    </div>
</body>
</html>
