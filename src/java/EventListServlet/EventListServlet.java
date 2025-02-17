/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package EventListServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Event;

@WebServlet("/events")
public class EventListServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/event_db";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Event> events = new ArrayList<>();
        String keyword = request.getParameter("keyword");
        String type = request.getParameter("type");
        String date = request.getParameter("date");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                String sql = "SELECT * FROM events WHERE 1=1";

                List<String> parameters = new ArrayList<>();
                if (keyword != null && !keyword.isEmpty()) {
                    sql += " AND (name LIKE ? OR location LIKE ?)";
                    parameters.add("%" + keyword + "%");
                    parameters.add("%" + keyword + "%");
                }
                if (type != null && !type.isEmpty()) {
                    sql += " AND type = ?";
                    parameters.add(type);
                }
                if (date != null && !date.isEmpty()) {
                    sql += " AND date = ?";
                    parameters.add(date);
                }

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    for (int i = 0; i < parameters.size(); i++) {
                        stmt.setString(i + 1, parameters.get(i));
                    }

                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            events.add(new Event(
                                    rs.getInt("id"),
                                    rs.getString("name"),
                                    rs.getString("date"),
                                    rs.getString("location"),
                                    rs.getString("description"),
                                    rs.getString("type")
                            ));
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
        }

        request.setAttribute("events", events);
        request.getRequestDispatcher("events.jsp").forward(request, response);
    }
}
