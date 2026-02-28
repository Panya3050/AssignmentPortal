package controller;

import model.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Connection con = DBConnection.getConnection();

            // 🔹 Check if email already exists
            String checkQuery = "SELECT * FROM users WHERE email=?";
            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setString(1, email);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // Email already exists
                request.setAttribute("errorMessage", "Email already registered!");
                request.getRequestDispatcher("register.jsp")
                       .forward(request, response);
                return;
            }

            // 🔹 Insert new user
            String insertQuery = 
                "INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(insertQuery);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect("login.jsp?success=registered");
            } else {
                request.setAttribute("errorMessage", "Registration failed!");
                request.getRequestDispatcher("register.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}