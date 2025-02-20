/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AddEventServlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/addEvent")
public class AddEventServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/event_db";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String type = request.getParameter("type");

        // Basic validation
        if (name == null || name.trim().isEmpty() ||
            date == null || date.trim().isEmpty() ||
            location == null || location.trim().isEmpty() ||
            type == null || type.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields except description are required.");
            request.getRequestDispatcher("add_event.jsp").forward(request, response);
            return;
        }

        // Insert data into the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            int rowsInserted;
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                String sql = "INSERT INTO events (name, date, location, description, type) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, date);
                stmt.setString(3, location);
                stmt.setString(4, description);
                stmt.setString(5, type);
                rowsInserted = stmt.executeUpdate();
                stmt.close();
            }

            if (rowsInserted > 0) {
                request.setAttribute("message", "Event added successfully!");
            } else {
                request.setAttribute("error", "Failed to add event.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.getRequestDispatcher("add_event.jsp").forward(request, response);
    }
}

