<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Assignment Portal</title>

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
            background: linear-gradient(135deg, #4e73df, #1cc88a);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: #fff;
            padding: 40px;
            width: 350px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            font-size: 14px;
            color: #555;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            transition: 0.3s;
        }

        .input-group input:focus {
            border-color: #4e73df;
            outline: none;
        }

        .login-btn {
            width: 100%;
            padding: 10px;
            background: #4e73df;
            border: none;
            color: white;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-btn:hover {
            background: #2e59d9;
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
            margin-top: 20px;
            font-size: 12px;
            color: #999;
        }

    </style>
</head>

<body>

    <div class="login-container">
        <h2>🔐 Login</h2>

        <form action="LoginServlet" method="post">

            <div class="input-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="login-btn">Login</button>

        </form>

        <div class="extra-links">
            Don't have an account? 
            <a href="register.jsp">Register</a>
        </div>

        <div class="footer-text">
            © 2026 Assignment Portal
        </div>
    </div>

</body>
</html>