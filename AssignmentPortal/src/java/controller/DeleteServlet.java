package controller;

import model.DBConnection;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            // Get file path
            String selectQuery = "SELECT file_path FROM submissions WHERE id=?";
            PreparedStatement ps1 = con.prepareStatement(selectQuery);
            ps1.setInt(1, id);
            ResultSet rs = ps1.executeQuery();

            String filePath = "";

            if (rs.next()) {
                filePath = rs.getString("file_path");
            }

            // Delete file from folder
            File file = new File(filePath);
            if (file.exists()) {
                file.delete();
            }

            // Delete from database
            String deleteQuery = "DELETE FROM submissions WHERE id=?";
            PreparedStatement ps2 = con.prepareStatement(deleteQuery);
            ps2.setInt(1, id);
            ps2.executeUpdate();

            response.sendRedirect("student_dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}