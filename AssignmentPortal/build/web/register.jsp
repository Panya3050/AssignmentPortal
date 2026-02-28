<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register | Assignment Portal</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            height: 100vh;
            background: linear-gradient(135deg, #36b9cc, #4e73df);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: #fff;
            padding: 35px;
            width: 380px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
        }

        .register-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .input-group {
            margin-bottom: 18px;
            text-align: left;
        }

        .input-group label {
            font-size: 14px;
            color: #555;
        }

        .input-group input,
        .input-group select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            transition: 0.3s;
        }

        .input-group input:focus,
        .input-group select:focus {
            border-color: #4e73df;
            outline: none;
        }

        .register-btn {
            width: 100%;
            padding: 10px;
            background: #1cc88a;
            border: none;
            color: white;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

        .register-btn:hover {
            background: #17a673;
        }

        .extra-links {
            margin-top: 15px;
            font-size: 14px;
        }

        .extra-links a {
            text-decoration: none;
            color: #4e73df;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }

        .footer-text {
            margin-top: 15px;
            font-size: 12px;
            color: #999;
        }

    </style>
</head>

<body>

    <div class="register-container">
        <h2>📝 Create Account</h2>

        <form action="RegisterServlet" method="post">

            <div class="input-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Enter your full name" required>
            </div>

            <div class="input-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Create password" required>
            </div>

            <div class="input-group">
                <label>Select Role</label>
                <select name="role" required>
                    <option value="">-- Select Role --</option>
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                </select>
            </div>

            <button type="submit" class="register-btn">Register</button>

        </form>

        <div class="extra-links">
            Already have an account? 
            <a href="login.jsp">Login</a>
        </div>

        <div class="footer-text">
            © 2026 Assignment Portal
        </div>
    </div>

</body>
</html>