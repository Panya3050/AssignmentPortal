package controller;

import model.DBConnection;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        try {

            Part filePart = request.getPart("file");
            String fileName = filePart.getSubmittedFileName();
            String cleanFileName = new File(fileName).getName();

            // ✅ Absolute folder (make sure this exists)
            String uploadPath = "C:/AssignmentUploads";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fullPath = uploadPath + "/" + cleanFileName;

            // 🔥 Manual file writing (IMPORTANT FIX)
            InputStream inputStream = filePart.getInputStream();
            FileOutputStream outputStream = new FileOutputStream(fullPath);

            byte[] buffer = new byte[1024];
            int bytesRead;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            outputStream.close();
            inputStream.close();

            // Save record in DB
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO submissions(student_id, file_name, file_path, status, marks, feedback) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, 1);
            ps.setString(2, cleanFileName);
            ps.setString(3, fullPath);
            ps.setString(4, "Pending");
            ps.setInt(5, 0);
            ps.setString(6, "Not Reviewed");

            ps.executeUpdate();

            response.sendRedirect("student_dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}