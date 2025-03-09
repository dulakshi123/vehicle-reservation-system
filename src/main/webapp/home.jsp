<%@ page import="com.dulakshi.vrs.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("_user_");
    boolean isLogged = user != null;
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="icon" href="assets/img/logo.png">
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
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f0f2f5;
        }

        .navbar {
            background-color: var(--primary);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
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

        .user-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .btn {
            padding: 8px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--secondary);
            color: white;
        }

        .btn-primary:hover {
            background-color: #e68a00;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .welcome-section {
            background: linear-gradient(135deg, var(--primary) 0%, #1a3a99 100%);
            border-radius: 15px;
            padding: 40px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .welcome-section h1 {
            font-size: 32px;
            margin-bottom: 15px;
        }

        .welcome-section p {
            font-size: 18px;
            margin-bottom: 25px;
            max-width: 600px;
        }

        .btn-large {
            padding: 12px 25px;
            font-size: 18px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            background-color: rgba(46, 78, 173, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            color: var(--primary);
            font-size: 24px;
        }

        .card h3 {
            margin-bottom: 15px;
            color: var(--dark);
        }

        .card p {
            color: var(--gray);
            margin-bottom: 20px;
        }

        .status-card {
            background: linear-gradient(135deg, #90f3a7 0%, #4ad36a 100%);
            color: white;
        }

        .status-card .status-icon {
            font-size: 32px;
            margin-bottom: 15px;
        }

        .recent-section {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .reservation-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .reservation-item:last-child {
            border-bottom: none;
        }

        .reservation-details {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .reservation-icon {
            width: 50px;
            height: 50px;
            background-color: rgba(46, 78, 173, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 20px;
        }

        .status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        .status-completed {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--success);
        }

        .status-pending {
            background-color: rgba(255, 193, 7, 0.1);
            color: var(--warning);
        }

        .status-canceled {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--danger);
        }

        .footer {
            background-color: var(--dark);
            color: white;
            padding: 30px 0;
            text-align: center;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 20px 0;
        }

        .footer-links a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: white;
        }

        @media (max-width: 900px) {
            .grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 15px;
            }

            .welcome-section {
                padding: 30px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">
        Mega<span>City</span>Cab
    </div>
    <div class="user-actions">
        <%
        if (isLogged) {
            String email = user.getEmail();
            %>
            <div class="user-info">
                <span><%= email %></span>
            </div>
            <button class="btn btn-primary" onclick="logout();">Logout</button>
            <%
        } else {
            %>
            <div class="user-info">
                <span>Guest User</span>
            </div>
            <button class="btn btn-primary" onclick="window.location='index.jsp';">Login</button>
            <%
        }
        %>
    </div>
</nav>

<div class="container">
    <section class="welcome-section">
        <h1>Welcome back, John!</h1>
        <p>Need a ride? Book a cab instantly or schedule for later. Our cabs are available 24/7 across Colombo City.</p>
        <button onclick="redirectToBooking()" class="btn btn-primary btn-large">Book a Cab Now</button>
    </section>

    <div class="grid">
        <div class="card">
            <div class="card-icon">📅</div>
            <h3>Book a Reservation</h3>
            <p>Schedule a cab in advance for your convenience.</p>
            <button onclick="redirectToBooking()" class="btn btn-primary">New Booking</button>
        </div>

        <div class="card">
            <div class="card-icon">🔍</div>
            <h3>Track Your Ride</h3>
            <p>View the status and details of your current ride.</p>
            <button onclick="redirectToStatus()" class="btn btn-primary">Track Now</button>
        </div>

        <div class="card">
            <div class="card-icon">📝</div>
            <h3>Booking History</h3>
            <p>Access your past bookings and trip details.</p>
            <button onclick="redirectToBookingHistory()" class="btn btn-primary">View History</button>
        </div>
    </div>

    <section class="recent-section">
        <div class="section-header">
            <h2>Recent Reservations</h2>
            <button class="btn btn-primary">View All</button>
        </div>

        <div id="reservations-container">
            <%-- Load Here recent reservations --%>
        </div>
    </section>
</div>

<footer class="footer">
    <div class="footer-content">
        <div class="footer-links">
            <a href="home.jsp">Home</a>
            <a href="about.jsp">About Us</a>
            <a href="about.jsp">Contact</a>
        </div>
        <p>&copy; 2025 Mega City Cab. All rights reserved.</p>
    </div>
</footer>
</body>

<script>
    function redirectToBooking() {
        window.location.href = "booking.jsp";
    }

    function redirectToStatus() {
        window.location.href = "status.jsp";
    }

    function redirectToBookingHistory() {
        // First navigate to the reservations page if not already there
        if (!window.location.href.includes('status.jsp')) {
            window.location.href = 'status.jsp?tab=history';
        } else {
            // If already on the status page, just switch to the history tab
            const tabs = document.querySelectorAll('.tab');
            const tabContents = document.querySelectorAll('.tab-content');

            // Activate the history tab (should be the second tab)
            tabs.forEach(t => t.classList.remove('active'));
            tabs[1].classList.add('active');

            // Show history content and hide other tab contents
            tabContents.forEach(content => {
                content.style.display = 'none';
            });
            tabContents[1].style.display = 'block';
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        fetchRecentReservations();

        // Check if there's a tab parameter in the URL
        const urlParams = new URLSearchParams(window.location.search);
        const tabParam = urlParams.get('tab');

        // If the tab parameter is 'history', switch to the history tab
        if (tabParam === 'history') {
            const tabs = document.querySelectorAll('.tab');
            const tabContents = document.querySelectorAll('.tab-content');

            // Activate the history tab
            tabs.forEach(t => t.classList.remove('active'));
            tabs[1].classList.add('active');

            // Show history content
            tabContents.forEach(content => {
                content.style.display = 'none';
            });
            tabContents[1].style.display = 'block';
        }
    });

    function fetchRecentReservations() {
        fetch('/reservation/customer/get', {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`Failed to fetch reservations. Status: ${response.status}`);
            }
            return response.json();
        })
        .then(reservations => {
            const limitedReservations = reservations.slice(0, 3);
            displayReservations(limitedReservations);
        })
        .catch(error => {
            console.error('Error fetching reservations:', error);
        });
    }

    function displayReservations(reservations) {
        const container = document.getElementById('reservations-container');
        container.innerHTML = '';
        container.innerHTML = reservations.map(function(res) {
            return '<div class="reservation-item">' +
                '<div class="reservation-details">' +
                '<div class="reservation-icon">🚖</div>' +
                '<div>' +
                '<h4>Booking #' + res.id + '</h4>' +
                '<p>' + formatDateTime(res.datetime) + '</p>' +
                '<p>From: ' + res.pickupLocation + ' • To: ' + res.dropOffLocation + '</p>' +
                '</div>' +
                '</div>' +
                '<span class="status ' + getStatusClass(res.status) + '">' + res.status + '</span>' +
                '</div>';
        }).join('');
    }

    function formatDateTime(datetime) {
        const dateObj = new Date(datetime);
        return dateObj.toLocaleString('en-US', {
            month: 'long', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit'
        });
    }

    function getStatusClass(status) {
        switch (status.toLowerCase()) {
            case 'completed': return 'status-completed';
            case 'pending': return 'status-pending';
            case 'cancelled': return 'status-cancelled';
            default: return 'status-default';
        }
    }

    function logout() {
        fetch('/user/logout', {
            method: 'GET'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`Failed to fetch reservations. Status: ${response.status}`);
            }
            return response.text();
        })
        .then(response => {
            alert(response);
            window.location.reload();
        })
        .catch(error => {
            console.error('Error fetching reservations:', error);
        });
    }
</script>
</html>