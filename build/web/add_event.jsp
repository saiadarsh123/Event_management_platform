<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Event</title>
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
        <h2>Create a New Event</h2>

        <!-- Display Success or Error Messages -->
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="addEvent" method="POST">
            <div class="form-group">
                <label>Event Name</label>
                <input type="text" name="name" required>
            </div>
            
            <div class="form-group">
                <label>Date</label>
                <input type="date" name="date" required>
            </div>

            <div class="form-group">
                <label>Location</label>
                <input type="text" name="location" required>
            </div>

            <div class="form-group">
                <label>Event Type</label>
                <select name="type" required>
                    <option value="">Select Type</option>
                    <option value="Conference">Conference</option>
                    <option value="Wedding">Wedding</option>
                    <option value="Workshop">Workshop</option>
                    <option value="Party">Party</option>
                </select>
            </div>

            <div class="form-group">
                <label>Description (Optional)</label>
                <textarea name="description" rows="3"></textarea>
            </div>

            <button type="submit">Create Event</button>
        </form>
        
        <a href="events" class="btn">View Events</a>
    </div>
</body>
</html>
