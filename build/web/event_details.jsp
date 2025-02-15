<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Event Details</title>
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
        <h2 class="text-center">Event Details</h2>

        <% 
            String eventId = request.getParameter("event_id");
            String userEmail = (String) session.getAttribute("user_email"); // Assume user is logged in and email is stored in session

            if (eventId == null || eventId.trim().isEmpty()) {
                out.println("<div class='alert alert-danger'>Event ID is missing in the request.</div>");
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_db", "root", "");

                    String sql = "SELECT * FROM events WHERE id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(eventId));
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
        %>
                        <div class="card">
                            <h3><%= rs.getString("name") %></h3>
                            <p><strong>Date:</strong> <%= rs.getDate("date") %></p>
                            <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                            <p><strong>Type:</strong> <%= rs.getString("type") %></p>
                            <p><strong>Description:</strong> <%= rs.getString("description") %></p>
                        </div>

                        <h3>RSVP</h3>

                        <% if (request.getAttribute("message") != null) { %>
                            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
                        <% } %>

                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                        <% } %>

                        <% 
                            // Check if the user has already RSVP'd for this event
                            if (userEmail != null && !userEmail.isEmpty()) {
                                try {
                                    String rsvpSql = "SELECT r.status, r.attendees FROM rsvps r JOIN users u ON r.user_id = u.id WHERE u.email = ? AND r.event_id = ?";
                                    PreparedStatement rsvpStmt = conn.prepareStatement(rsvpSql);
                                    rsvpStmt.setString(1, userEmail);
                                    rsvpStmt.setInt(2, Integer.parseInt(eventId));
                                    ResultSet rsvpRs = rsvpStmt.executeQuery();

                                    if (rsvpRs.next()) {
                                        String currentStatus = rsvpRs.getString("status");
                                        int currentAttendees = rsvpRs.getInt("attendees");
                        %>
                                        <h3>Your RSVP</h3>
                                        <p><strong>Status:</strong> <%= currentStatus %></p>
                                        <p><strong>Attendees:</strong> <%= currentAttendees %></p>
                                        <p><strong>Want to update?</strong> Submit the form again.</p>
                        <%
                                    }
                                    rsvpRs.close();
                                    rsvpStmt.close();
                                } catch (Exception e) {
                                    out.println("<div class='alert alert-danger'>Error retrieving your RSVP: " + e.getMessage() + "</div>");
                                }
                            }
                        %>

                        <form action="RSVPServlet" method="post">
                            <input type="hidden" name="event_id" value="<%= eventId %>">

                            <label for="email">Email:</label>
                            <input type="email" name="email" value="<%= userEmail != null ? userEmail : "" %>" required>

                            <label for="status">RSVP Status:</label>
                            <select name="status" required>
                                <option value="Attending">Attending</option>
                                <option value="Not Attending">Not Attending</option>
                            </select>

                            <label for="attendees">Number of Attendees:</label>
                            <input type="number" name="attendees" min="1" value="1" required>

                            <button type="submit">Submit RSVP</button>
                        </form>

                        <a href="events" class="btn">Back to Events</a>
        <%
                    } else {
                        out.println("<div class='alert alert-danger'>No event found for event_id: " + eventId + "</div>");
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (NumberFormatException e) {
                    out.println("<div class='alert alert-danger'>Invalid event ID format.</div>");
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger'>Database error: " + e.getMessage() + "</div>");
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                }
            }
        %>
    </div>
</body>
</html>
