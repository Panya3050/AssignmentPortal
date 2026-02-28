<%@ page import="java.sql.*,model.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Animation CSS -->
    <style>

body {
    background: linear-gradient(to right, #eef2f7, #dfe9f3);
    font-family: 'Segoe UI', sans-serif;
    transition: 0.3s ease;
    padding-bottom: 40px;
}

/* Navbar */
.navbar {
    background: linear-gradient(to right, #4e73df, #224abe);
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}

/* Cards */
.card {
    border-radius: 15px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    transition: 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
}

/* Statistics Cards */
.stat-card {
    text-align: center;
    padding: 20px;
}

/* Table */
.table-container {
    margin-top: 30px;
}

table {
    border-radius: 10px;
    overflow: hidden;
}

tbody tr {
    transition: 0.2s ease;
}

tbody tr:hover {
    background-color: #f1f3f9;
}

/* Buttons */
.btn {
    border-radius: 20px;
    transition: 0.3s ease;
}

.btn:hover {
    transform: translateY(-2px);
}

/* Dark Mode Improved */

.dark-mode {
    background-color: #0f172a;
    color: #ffffff;
}

.dark-mode .card {
    background-color: #1e293b;
    color: #ffffff;
    box-shadow: 0 6px 18px rgba(0,0,0,0.4);
}

.dark-mode .table {
    background-color: #1e293b;
    color: white;
}

.dark-mode .table thead {
    background-color: #111827;
}

.dark-mode tbody tr:hover {
    background-color: #334155;
}

.dark-mode .navbar {
    background: #000000 !important;
}
.stat-card {
    height: 160px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}


.dashboard-title {
    font-weight: 900;
    font-size: 22px;
    background: linear-gradient(45deg, #ffffff, #00c6ff, #ffffff);
    background-size: 300%;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: gradientMove 4s infinite;
}

@keyframes gradientMove {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Optional: Better navbar spacing */
.navbar {
    padding: 12px 20px;
}

.modern-navbar {
    background: linear-gradient(90deg, #1e3c72, #2a5298);
    padding: 12px 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}


</style>

</head>

<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark modern-navbar">

    <a class="navbar-brand dashboard-title">
        📘 Teacher Dashboard
    </a>

    <button onclick="toggleDarkMode()" 
            class="btn btn-outline-light btn-sm ml-2">
        🌙 Dark Mode
    </button>

    <div class="ml-auto">
        <span class="text-white mr-3">
            Welcome, <strong><%= session.getAttribute("name") %></strong>
        </span>
        <a href="LogoutServlet" class="btn btn-light btn-sm">
            Logout
        </a>
    </div>

    </nav>

            <%
    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    ResultSet totalRS = st.executeQuery("SELECT COUNT(*) FROM submissions");
    totalRS.next();
    int total = totalRS.getInt(1);

    ResultSet approvedRS = st.executeQuery("SELECT COUNT(*) FROM submissions WHERE status='Approved'");
    approvedRS.next();
    int approved = approvedRS.getInt(1);

    ResultSet pendingRS = st.executeQuery("SELECT COUNT(*) FROM submissions WHERE status='Pending'");
    pendingRS.next();
    int pending = pendingRS.getInt(1);
    %>

    <div class="container mt-4">

    <div class="row text-center mb-4">

        <div class="col-md-4 mb-3">
            <div class="card stat-card p-4">
                <i class="fa-solid fa-file fa-2x text-primary mb-2"></i>
                <h2 class="font-weight-bold"><%= total %></h2>
                <p>Total Submissions</p>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="card stat-card p-4">
                <i class="fa-solid fa-circle-check fa-2x text-success mb-2"></i>
                <h2 class="font-weight-bold"><%= approved %></h2>
                <p>Approved</p>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="card stat-card p-4">
                <i class="fa-solid fa-clock fa-2x text-warning mb-2"></i>
                <h2 class="font-weight-bold"><%= pending %></h2>
                <p>Pending</p>
            </div>
        </div>

    </div>

</div>

    <div class="container mt-4">

        <div class="card p-4">

            <h4 class="mb-4 text-primary font-weight-bold">
                📂 Student Submissions
            </h4>

            <div class="table-responsive">
                <div class="table-container mt-4">

            <table class="table table-hover">

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Student</th>
                        <th>File</th>
                        <th>Status</th>
                        <th>Marks</th>
                        <th>Feedback</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>

    <%
    try {



        String query =
        "SELECT s.id, u.name, s.file_name, s.status, s.marks, s.feedback " +
        "FROM submissions s " +
        "JOIN users u ON s.student_id = u.id";

        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {

            String status = rs.getString("status");
    %>

    <tr>

    <td><%= rs.getInt("id") %></td>

    <td><strong><%= rs.getString("name") %></strong></td>

    <td><%= rs.getString("file_name") %></td>

    <td>
    <% if("Approved".equals(status)) { %>
        <span class="badge badge-success">Approved</span>
    <% } else if("Rejected".equals(status)) { %>
        <span class="badge badge-danger">Rejected</span>
    <% } else { %>
        <span class="badge badge-warning text-dark">Pending</span>
    <% } %>
    </td>

    <td><%= rs.getInt("marks") %></td>
    <td><%= rs.getString("feedback") %></td>

    <td>

    <a href="DownloadServlet?id=<%= rs.getInt("id") %>"
       class="btn btn-sm btn-outline-primary mb-1">
       👁 View
    </a>

    <a href="ApproveServlet?id=<%= rs.getInt("id") %>"
       class="btn btn-sm btn-outline-success mb-1">
       ✔ Approve
    </a>

    <a href="RejectServlet?id=<%= rs.getInt("id") %>"
       class="btn btn-sm btn-outline-danger mb-1">
       ✖ Reject
    </a>

    </td>

    </tr>

    <%
        }

    } catch(Exception e) {
        e.printStackTrace();
    }
    %>

                </tbody>

            </table>

            </div>

        </div>

        </div>
        <script>
        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
        }
        </script>

</body>
</html>