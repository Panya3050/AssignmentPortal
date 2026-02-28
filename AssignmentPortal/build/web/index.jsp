<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assignment Submission Portal</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            background: linear-gradient(-45deg, #4e73df, #1cc88a, #36b9cc, #6610f2);
            background-size: 400% 400%;
            animation: gradientBG 12s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Floating circles */
        .circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            animation: float 6s ease-in-out infinite;
        }

        .circle:nth-child(1) {
            width: 200px;
            height: 200px;
            top: 10%;
            left: 10%;
        }

        .circle:nth-child(2) {
            width: 300px;
            height: 300px;
            bottom: 10%;
            right: 15%;
            animation-duration: 8s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-30px); }
        }

        /* Glass card */
        .container {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(15px);
            padding: 50px;
            border-radius: 20px;
            text-align: center;
            color: white;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            animation: fadeIn 1.5s ease-in-out;
            z-index: 1;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            font-size: 38px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        p {
            font-size: 18px;
            margin-bottom: 35px;
            font-weight: 300;
        }

        .btn {
            display: inline-block;
            padding: 12px 35px;
            margin: 10px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.4s ease;
        }

        .login-btn {
            background: white;
            color: #4e73df;
        }

        .login-btn:hover {
            background: #4e73df;
            color: white;
            transform: scale(1.05);
        }

        .register-btn {
            background: #ffce00;
            color: black;
        }

        .register-btn:hover {
            background: black;
            color: #ffce00;
            transform: scale(1.05);
        }

        .footer {
            position: absolute;
            bottom: 20px;
            color: white;
            font-size: 14px;
            opacity: 0.8;
        }

    </style>
</head>

<body>

    <!-- Floating Background Elements -->
    <div class="circle"></div>
    <div class="circle"></div>

    <div class="container">
        <h1>📚 Assignment Submission Portal</h1>
        <p>Upload, Track & Manage Academic Assignments Efficiently</p>

        <a href="login.jsp" class="btn login-btn">Login</a>
        <a href="register.jsp" class="btn register-btn">Register</a>
    </div>

    <div class="footer">
        © 2026 Assignment Portal | Developed by You 👨‍💻
    </div>

</body>
</html>