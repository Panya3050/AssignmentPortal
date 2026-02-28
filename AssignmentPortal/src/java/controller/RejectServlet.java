package controller;

import model.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RejectServlet")
public class RejectServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            String query = "UPDATE submissions SET status='Rejected' WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("teacher_dashboard.jsp");

        } catch(Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}