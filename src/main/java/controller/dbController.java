package controller;

import dbconfig.dbconfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/db")
public class dbController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String[]> users = new ArrayList<>();

        try (Connection conn = dbconfig.getConnection()) {
            String sql = "SELECT * FROM users";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] user = new String[4];
                user[0] = rs.getString("id");
                user[1] = rs.getString("fullName");
                user[2] = rs.getString("email");
                user[3] = rs.getString("password");
                users.add(user);
            }

            request.setAttribute("userList", users);
            request.getRequestDispatcher("/WEB-INF/pages/db.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
