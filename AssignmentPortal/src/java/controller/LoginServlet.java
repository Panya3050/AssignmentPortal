package controller;

import model.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String role = rs.getString("role");
                HttpSession session = request.getSession();
                session.setAttribute("name", rs.getString("name"));

                if (role.equals("student")) {
                    response.sendRedirect("student_dashboard.jsp");
                } else if (role.equals("teacher")) {
                    response.sendRedirect("teacher_dashboard.jsp");
                }

            } else {
                response.getWriter().println("Invalid Credentials");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}