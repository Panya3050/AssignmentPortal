<%@ page import="java.sql.*,model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- FontAwesome -->
    <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>

    body {
        background: linear-gradient(to right, #f1f4f9, #dfe9f3);
        font-family: 'Segoe UI', sans-serif;
        transition: 0.3s;
    }

    .navbar {
        background: linear-gradient(to right, #11998e, #38ef7d);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .card {
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        transition: 0.3s;
    }

    .card:hover {
        transform: translateY(-5px);
    }

    
    .dark-mode {
        background-color: #0f172a;
        color: #ffffff;
    }

    /* Navbar */
    .dark-mode .navbar {
        background: #000000 !important;
    }

    /* Cards */
    .dark-mode .card {
        background-color: #1e293b;
        color: #ffffff;
        box-shadow: 0 6px 18px rgba(0,0,0,0.4);
    }

    /* Table */
    .dark-mode .table {
        background-color: #1e293b;
        color: #ffffff;
    }

    /* Table Header */
    .dark-mode .table thead {
        background-color: #111827 !important;
        color: white;
    }

    /* Table Hover */
    .dark-mode tbody tr:hover {
        background-color: #334155;
    }

    /* Buttons in dark mode */
    .dark-mode .btn-light {
        background-color: #ffffff;
        color: #000000;
    }
    .dark-mode a {
    color: #4dabf7;
    }

    </style>

</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-dark">

    <span class="navbar-brand">
        📘 Student Dashboard
    </span>

    <div>
        <button onclick="toggleDarkMode()" 
                class="btn btn-light btn-sm">
            🌙 Dark Mode
        </button>

        <a href="LogoutServlet" 
           class="btn btn-light btn-sm ml-2">
            Logout
        </a>
    </div>

</nav>

<div class="container mt-4">

<%
String name = (String) session.getAttribute("name");
if(name == null){
    response.sendRedirect("login.jsp");
    return;
}

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT COUNT(*) FROM submissions WHERE student_id=?");

ps.setInt(1, 1); // Replace with real student id later
ResultSet rs = ps.executeQuery();
rs.next();
int total = rs.getInt(1);
%>

<!-- Welcome Card -->
<div class="card p-4 mb-4 text-center">
    <h3>Welcome, <%= name %> 👋</h3>
    <p>Total Submitted Assignments: <strong><%= total %></strong></p>
</div>

<!-- Upload Assignment -->
<div class="card p-4 mb-4">
    <h5>📤 Upload Assignment</h5>

    <form action="UploadServlet" 
          method="post" 
          enctype="multipart/form-data">

        <input type="file" 
               name="file" 
               class="form-control mb-3"
               required>

        <button type="submit" 
                class="btn btn-success">
            Upload
        </button>

    </form>
</div>

<!-- My Submissions -->
<div class="card p-4">

<h5>📂 My Submissions</h5>

<table class="table table-hover mt-3">

<thead class="thead-dark">
<tr>
<th>ID</th>
<th>File</th>
<th>Status</th>
<th>Marks</th>
</tr>
</thead>

<tbody>

<%
PreparedStatement ps2 = con.prepareStatement(
"SELECT * FROM submissions WHERE student_id=?");

ps2.setInt(1, 1); // Later replace with real session id
ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){
%>

<tr>

<td><%= rs2.getInt("id") %></td>

<td><%= rs2.getString("file_name") %></td>


<td>

<!-- VIEW BUTTON -->
<a href="DownloadServlet?id=<%= rs2.getInt("id") %>"
   class="btn btn-sm btn-view">
   <i class="fa fa-eye"></i> View
</a>

<!-- DELETE BUTTON -->
<a href="DeleteServlet?id=<%= rs2.getInt("id") %>"
   class="btn btn-sm btn-delete"
   onclick="return confirm('Are you sure you want to delete?');">
   <i class="fa fa-trash"></i> Delete
</a>

</td>

<td><%= rs2.getString("status") %></td>

<td><%= rs2.getInt("marks") %></td>

</tr>

<%
}
%>

</tbody>
</table>

</div>

</div>

<script>
function toggleDarkMode(){
    document.body.classList.toggle("dark-mode");
}
</script>

</body>
</html>