package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DBConnection;

@WebServlet("/MarksServlet")
public class MarksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int marks = Integer.parseInt(request.getParameter("marks"));
        String feedback = request.getParameter("feedback");

        try {
            Connection con = DBConnection.getConnection();

            String query = "UPDATE submissions SET marks=?, feedback=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, marks);
            ps.setString(2, feedback);
            ps.setInt(3, id);

            ps.executeUpdate();

            response.sendRedirect("teacher_dashboard.jsp");

        } catch(Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}