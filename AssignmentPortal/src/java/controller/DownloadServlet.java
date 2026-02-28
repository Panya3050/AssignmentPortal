package controller;

import model.DBConnection;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT file_name, file_path FROM submissions WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String fileName = rs.getString("file_name");
                String filePath = rs.getString("file_path");

                File file = new File(filePath);

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition",
                        "inline; filename=\"" + fileName + "\"");

                FileInputStream fis = new FileInputStream(file);
                OutputStream os = response.getOutputStream();

                byte[] buffer = new byte[1024];
                int bytesRead;

                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                fis.close();
                os.close();
            }

        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}