<%@ page import="com.dulakshi.vrs.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User loggedUser = (User) session.getAttribute("_user_");
    if (loggedUser != null) {
        response.sendRedirect("dashboard.jsp");
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Admin Login</title>
    <link rel="icon" href="../assets/img/logo.png">
    <style>
        :root {
            --primary: #2e4ead;
            --secondary: #ff9800;
            --dark: #333;
            --light: #f8f9fa;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --gray: #6c757d;
            --light-gray: #e9ecef;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: var(--primary);
            padding: 15px 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            color: white;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
        }

        .logo span {
            color: var(--secondary);
        }

        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, var(--primary) 0%, #1a3a99 100%);
            color: white;
            padding: 25px 30px;
            text-align: center;
        }

        .login-header h2 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .login-header p {
            opacity: 0.9;
        }

        .login-form {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: var(--dark);
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 14px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(46, 78, 173, 0.2);
        }

        .btn {
            padding: 14px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: #263d8f;
        }

        .btn-block {
            display: block;
            width: 100%;
        }

        .login-footer {
            padding: 20px 30px;
            text-align: center;
            border-top: 1px solid var(--light-gray);
            color: var(--gray);
            font-size: 14px;
        }

        .login-footer a {
            color: var(--primary);
            text-decoration: none;
        }

        .login-icon {
            text-align: center;
            font-size: 64px;
            margin-bottom: 20px;
            color: var(--primary);
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        .icon-input {
            padding-left: 45px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .remember-me input {
            margin-right: 8px;
        }

        @media (max-width: 500px) {
            .login-card {
                box-shadow: none;
                border-radius: 0;
            }

            .login-form {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">
        Mega<span>City</span>Cab <strong>Admin</strong>
    </div>
</nav>

<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <h2>Admin Login</h2>
            <p>Enter your credentials to access the admin dashboard</p>
        </div>

        <form class="login-form" id="login-form">
            <div class="login-icon">
                👤
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-group">
                    <input type="email" id="email" class="form-control" placeholder="admin@megacitycab.com" required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-group">
                    <input type="password" id="password" class="form-control" placeholder="Enter your password"
                           required>
                </div>
            </div>


            <button type="submit" class="btn btn-primary btn-block">Login to Dashboard</button>
        </form>

        <script>
            document.getElementById('login-form').addEventListener('submit', function (e) {
                e.preventDefault();
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                const userRole = "ADMIN";

                if (!email || !password) {
                    alert('Please fill in all fields');
                    return;
                }

                const loginData = {username: email, password: password, userRole: userRole};

                fetch('/user/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(loginData)
                })
                .then(response => response.text())
                .then(result => {
                    alert('Login successful! Redirecting...');
                    window.location.href = "dashboard.jsp";
                })
                .catch(error => {
                    console.error('Login failed:', error);
                    alert(error);
                });
            });
        </script>
    </div>
</div>
</body>
</html>