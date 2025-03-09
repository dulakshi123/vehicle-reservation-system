<%@ page import="com.dulakshi.vrs.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User loggedUser = (User) session.getAttribute("_user_");
    if(loggedUser!=null) {
        response.sendRedirect("home.jsp");
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Login/Register</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="icon" href="assets/img/logo.png">
 
</head>
<body>
    <div class="container">
        <div class="left-panel">
            <div class="branding">
                <h1>Mega City Cab</h1>
                <p>Your trusted ride service in Colombo</p>
            </div>

            <div class="features">
                <h3>Why Choose Us?</h3>
                <div class="feature-item">
                    <div class="feature-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10"></circle>
                            <polyline points="12 6 12 12 16 14"></polyline>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <h4>24/7 Service</h4>
                        <p>Available anytime, anywhere in Colombo</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="8.5" cy="7" r="4"></circle>
                            <line x1="20" y1="8" x2="20" y2="14"></line>
                            <line x1="23" y1="11" x2="17" y2="11"></line>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <h4>Professional Drivers</h4>
                        <p>Safe and courteous service guaranteed</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="2" y="5" width="20" height="14" rx="2"></rect>
                            <line x1="2" y1="10" x2="22" y2="10"></line>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <h4>Easy Payment</h4>
                        <p>Multiple payment options available</p>
                    </div>
                </div>
            </div>

            <div class="taxi-illustration">
                <!-- <svg width="150" height="80" viewBox="0 0 24 24" fill="#ffffff" stroke="none">
                    <path d="M21.96 11.22C21.57 10.82 20.98 10.79 20.56 11.16C20.13 11.54 20.1 12.13 20.47 12.55C20.58 12.68 20.73 12.77 20.88 12.83C20.85 13.3 20.51 13.69 20.06 13.8C19.62 13.77 19.26 13.47 19.16 13.04C19.03 12.46 18.47 12.07 17.89 12.2C17.31 12.32 16.92 12.89 17.05 13.47C17.36 14.73 18.47 15.59 19.77 15.59L19.93 15.58C19.95 15.58 19.97 15.58 19.99 15.58C21.55 15.46 22.69 14.08 22.56 12.52C22.53 12.05 22.32 11.59 21.96 11.22"/>
                    <path d="M18.34 4.0001L16 5.0001L15.25 5.5001C14.29 6.1001 13.31 6.6701 12.42 7.3101L11.78 7.7401L11.75 7.8501C11.67 8.1901 11.52 8.6201 11.35 9.0701L11.15 9.6101L11.83 10.0201C12.12 10.2001 12.42 10.3801 12.72 10.5601L13.18 10.8301L13.66 10.5601C14.72 9.9401 15.87 9.4901 17.07 9.2401L17.28 9.2001C17.62 9.1301 17.89 9.0701 18.15 9.0201L18.64 8.9301V8.4301C18.64 7.5201 18.65 6.5901 18.65 5.6701V4.4301L18.34 4.0001"/>
                    <path d="M11.37 8.0001L10.52 8.4601L9.97 8.7401C9.23 9.1101 8.36 9.5801 7.42 10.1101L7.3 10.1801C5.89 11.0001 4.09 12.0701 2.43 13.4301C2.01 13.7701 1.83 14.3501 2 14.8701L2.77 16.7201C2.92 17.1601 3.18 17.5601 3.52 17.8701C3.83 18.1601 4.23 18.3501 4.66 18.4201L5.03 18.4801C5.07 18.4901 5.11 18.4901 5.15 18.4901H6.27C7.58 18.4901 9.53 18.4801 10.88 18.4701L12 18.4601C14.46 18.4601 16.55 16.3701 16.55 13.9201C16.55 13.4801 16.48 13.0501 16.34 12.6501L16.05 11.8401L15.23 11.7801C14.71 11.7401 14.2 11.7201 13.7 11.7201H13.23L12.76 11.9001C12.09 12.1501 11.45 12.4401 10.85 12.7601L10.36 13.0301L10.73 13.7101C10.81 13.8701 10.86 14.0501 10.86 14.2301C10.86 14.8201 10.37 15.3001 9.77 15.3001C9.18 15.3001 8.69 14.8201 8.69 14.2301C8.69 14.0301 8.75 13.8301 8.86 13.6601L9.19 13.1001L8.67 12.7401C8.44 12.5801 8.07 12.3101 7.74 12.0801L7.09 11.6401L6.73 12.2601C6.59 12.5101 6.51 12.7901 6.51 13.0801C6.51 13.8301 6.84 14.5301 7.42 15.0001C7.94 15.4101 8.58 15.6401 9.24 15.6401H15.54V14.8901C15.54 13.3601 14.29 12.1201 12.76 12.1201H12.53L12.33 12.2301C11.58 12.6601 10.79 13.0601 9.96 13.4201L9.52 13.6301L9.59 14.1001C9.61 14.2401 9.58 14.3801 9.51 14.5101C9.43 14.6301 9.31 14.7201 9.17 14.7601C9.04 14.8001 8.9 14.7901 8.77 14.7301C8.64 14.6601 8.54 14.5401 8.49 14.4001C8.38 14.1201 8.53 13.8201 8.81 13.7101L9.15 13.5701L8.99 13.2401C8.84 12.9201 8.83 12.5601 8.95 12.2301C9.07 11.9001 9.31 11.6301 9.63 11.4601L9.82 11.3501L9.8 11.1301C9.77 10.8701 9.68 10.5901 9.53 10.2901L9.41 10.0401L9.17 9.8901C8.85 9.6801 8.58 9.5201 8.31 9.3601L7.69 8.9801L7.24 9.4501C6.85 9.8601 6.26 10.0301 5.73 9.8901C5.19 9.7501 4.77 9.3301 4.64 8.7901C4.44 7.9301 4.99 7.0701 5.85 6.8601C6.71 6.6601 7.58 7.2001 7.78 8.0601C7.82 8.2401 7.83 8.4201 7.81 8.6001L7.76 8.9901L8.12 9.1501C8.3 9.2301 8.48 9.3201 8.66 9.4101L9.01 9.5901L9.38 9.3601C9.58 9.2301 9.79 9.0901 10.01 8.9601L10.47 8.6701L10.2 8.2401C9.91 7.7701 9.84 7.1901 10.01 6.6801C10.18 6.1601 10.57 5.7501 11.09 5.5601C12.1 5.1901 13.19 5.8801 13.56 6.8901C13.93 7.9001 13.25 9.0001 12.23 9.3601C12.08 9.4101 11.93 9.4501 11.78 9.4701L11.45 9.5001L11.39 9.8201C11.36 9.9701 11.32 10.1101 11.28 10.2501L11.2 10.5201L11.43 10.6701C11.64 10.8101 11.86 10.9501 12.08 11.0801L12.5 11.3301L12.92 11.0901C13.68 10.6401 14.48 10.2801 15.33 9.9901L15.72 9.8701L15.68 9.4601C15.67 9.3101 15.7 9.1601 15.77 9.0201C15.88 8.8101 16.07 8.6501 16.3 8.5601C16.8 8.3801 17.36 8.6301 17.54 9.1301C17.71 9.6301 17.47 10.1901 16.97 10.3701C16.77 10.4501 16.55 10.4501 16.35 10.3901L15.97 10.2801L15.69 10.5601C15.47 10.7701 15.15 10.8801 14.83 10.8501C14.51 10.8201 14.22 10.6601 14.05 10.4101L13.91 10.1801L13.65 10.0401C13.32 9.8601 12.99 9.6701 12.68 9.4701L12.32 9.2601L12.18 9.6301C12.11 9.8201 12.07 10.0201 12.04 10.2101L12.01 10.4401L12.21 10.5801C12.46 10.7501 12.7 10.9301 12.93 11.1101L13.12 11.2601L13.37 11.2701C15.29 11.2901 16.84 12.8701 16.84 14.7901V16.9501H9.24C8.36 16.9501 7.5 16.6501 6.81 16.1001C5.96 15.4101 5.5 14.4101 5.5 13.3401V13.1801L5.37 13.0901C4.72 12.6101 4.12 12.1401 3.57 11.6901L3.13 11.3301L2.82 11.7301C2.45 12.2001 2.34 12.8101 2.53 13.3701L3.31 15.2201C3.39 15.4601 3.54 15.6801 3.73 15.8501C3.9 16.0101 4.12 16.1201 4.36 16.1601L4.73 16.2201H5.99C7.24 16.2201 9.26 16.2101 10.62 16.2001H10.99C12.93 16.2001 14.51 14.6201 14.51 12.6801C14.51 12.3401 14.46 12.0101 14.36 11.6901L14.15 11.1001L13.53 11.0201C13.07 10.9601 12.61 10.9401 12.15 10.9401L11.57 10.9501L11.45 11.5301C11.39 11.8101 11.2 12.0501 10.95 12.2001C10.69 12.3501 10.39 12.4001 10.1 12.3401C9.54 12.2201 9.17 11.6801 9.28 11.1201C9.33 10.8601 9.47 10.6201 9.67 10.4601C9.87 10.3001 10.12 10.2101 10.38 10.2201L10.96 10.2401L11.17 9.6701C11.27 9.3901 11.35 9.1101 11.41 8.8301L11.5 8.3801L11.37 8.0001"/>
                </svg> -->
            </div>
        </div>

        <div class="right-panel">
            <div class="tabs">
                <div class="tab active" id="login-tab">Login</div>
                <div class="tab" id="register-tab">Register</div>
            </div>

            <div class="form-container">
                <form class="form active" id="login-form">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter your email">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" placeholder="Enter your password">
                    </div>
                    <button type="submit" class="btn">Login</button>
                    <!-- <div class="forgot-password">
                        <a href="#">Forgot Password?</a>
                    </div> -->

                 
                </form>

                <form class="form" id="register-form">
                    <div class="register-form">
                        <div class="form-group">
                            <label for="reg-name">Full Name</label>
                            <input type="text" class="form-control" id="reg-name" placeholder="Enter your full name">
                        </div>
                        <div class="form-group">
                            <label for="reg-email">Email Address</label>
                            <input type="email" class="form-control" id="reg-email" placeholder="Enter your email">
                        </div>
                        <div class="form-group">
                            <label for="reg-mobile">Mobile Number</label>
                            <input type="tel" class="form-control" id="reg-mobile" placeholder="Enter your mobile number">
                        </div>
                        <div class="form-group">
                            <label for="reg-nic">NIC Number</label>
                            <input type="text" class="form-control" id="reg-nic" placeholder="Enter your NIC number">
                        </div>
                        <div class="form-group">
                            <label for="reg-address">Address</label>
                            <textarea class="form-control" id="reg-address" rows="3" placeholder="Enter your address"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="reg-password">Password</label>
                            <input type="password" class="form-control" id="reg-password" placeholder="Create a password">
                        </div>
                        <div class="form-group">
                            <label for="reg-confirm-password">Confirm Password</label>
                            <input type="password" class="form-control" id="reg-confirm-password" placeholder="Confirm your password">
                        </div>
                    </div>
                    <button type="submit" class="btn">Register</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Tab switching functionality
        const loginTab = document.getElementById('login-tab');
        const registerTab = document.getElementById('register-tab');
        const loginForm = document.getElementById('login-form');
        const registerForm = document.getElementById('register-form');

        loginTab.addEventListener('click', function() {
            loginTab.classList.add('active');
            registerTab.classList.remove('active');
            loginForm.classList.add('active');
            registerForm.classList.remove('active');
        });

        registerTab.addEventListener('click', function() {
            registerTab.classList.add('active');
            loginTab.classList.remove('active');
            registerForm.classList.add('active');
            loginForm.classList.remove('active');
        });

        document.getElementById('login-form').addEventListener('submit', function(e) {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const userRole = "CUSTOMER";
            
            if (!email || !password) {
                alert('Please fill in all fields');
                return;
            }

            const loginData = { username: email, password: password, userRole: userRole };

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
                window.location.href = "home.jsp";
            })
            .catch(error => {
                console.error('Login failed:', error);
                alert(error);
            });
        });

        document.getElementById('register-form').addEventListener('submit', function(e) {
            e.preventDefault();
            const name = document.getElementById('reg-name').value;
            const email = document.getElementById('reg-email').value;
            const mobile = document.getElementById('reg-mobile').value;
            const nic = document.getElementById('reg-nic').value;
            const address = document.getElementById('reg-address').value;
            const password = document.getElementById('reg-password').value;
            const confirmPassword = document.getElementById('reg-confirm-password').value;
            
            if (!name || !email || !mobile || !nic || !address || !password || !confirmPassword) {
                alert('Please fill in all required fields');
                return;
            }

            if (password !== confirmPassword) {
                alert('Passwords do not match');
                return;
            }

            const customerData = { name, email, password, mobile, nic, address };

            fetch('/user/register/customer', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(customerData)
            })
            .then(response => response.text())
            .then(result => {
                alert(result);
                loginTab.classList.add('active');
                registerTab.classList.remove('active');
                loginForm.classList.add('active');
                registerForm.classList.remove('active');
            })
            .catch(error => {
                console.error('Registration failed:', error);
                alert('Failed to register. Please try again.');
            });
        });
    </script>
</body>
</html>