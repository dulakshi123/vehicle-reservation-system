<%@ page import="com.dulakshi.vrs.entity.User" %>
<%@ page import="com.dulakshi.vrs.entity.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("_user_");

    if (user == null || !user.getUserRole().equals(UserRole.ADMIN)) {
        response.sendRedirect("login.jsp");
    }
%>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../assets/img/logo.png">
    <title>Mega City Cab - Admin Dashboard</title>
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #e74c3c;
            --accent: #3498db;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
            --gray: #95a5a6;
            --text: #333;
            --sidebar-width: 250px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f6fa;
            color: var(--text);
            overflow-x: hidden;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background-color: var(--primary);
            position: fixed;
            left: 0;
            top: 0;
            color: white;
            z-index: 100;
            transition: all 0.3s ease;
        }

        .brand {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .brand h2 {
            font-weight: bold;
        }

        .brand span {
            color: var(--secondary);
        }

        .sidebar-menu {
            margin-top: 20px;
        }

        .sidebar-menu a {
            display: block;
            padding: 15px 25px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
        }

        .sidebar-menu a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .sidebar-menu a.active {
            background-color: var(--secondary);
            color: white;
            border-left: 5px solid white;
        }

        .sidebar-menu i {
            font-size: 18px;
            min-width: 20px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 20px;
            transition: all 0.3s ease;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .toggle-btn {
            background: none;
            border: none;
            color: var(--primary);
            font-size: 24px;
            cursor: pointer;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .user-name {
            font-weight: 500;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
        }

        .card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .card-drivers .card-icon {
            background-color: rgba(52, 152, 219, 0.1);
            color: var(--accent);
        }

        .card-vehicles .card-icon {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success);
        }

        .card-bookings .card-icon {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning);
        }

        .card-revenue .card-icon {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--secondary);
        }

        .card-value {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .card-label {
            color: var(--gray);
            font-size: 14px;
        }

        .section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
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
            background-color: var(--accent);
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead th {
            background-color: #f8f9fa;
            text-align: left;
            padding: 12px 15px;
            font-weight: 600;
            color: var(--dark);
        }

        tbody td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        .status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }

        .status-active {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success);
        }

        .status-pending {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning);
        }

        .status-cancelled {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
        }

        .status-checked_in {
            background-color: rgba(52, 152, 219, 0.1);
            color: var(--accent);
        }

        .status-booked {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success);
        }

        .action-btns {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            width: 30px;
            height: 30px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .view-btn {
            background-color: var(--accent);
        }

        .edit-btn {
            background-color: var(--warning);
        }

        .delete-btn {
            background-color: var(--danger);
        }

        .action-btn:hover {
            opacity: 0.8;
        }

        /* Responsive design */
        @media (max-width: 1200px) {
            .card-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                left: -250px;
            }

            .main-content {
                margin-left: 0;
            }

            .sidebar.active {
                left: 0;
            }

            .main-content.active {
                margin-left: var(--sidebar-width);
            }

            .card-container {
                grid-template-columns: 1fr;
            }
        }

        /* Icons */
        .icon {
            display: inline-block;
            width: 24px;
            height: 24px;
            text-align: center;
        }
    </style>
</head>

<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="brand">
        <h2>Mega<span>City</span>Cab</h2>
        <p>Admin Panel</p>
    </div>

    <div class="sidebar-menu">
        <a href="dashboard.jsp" class="active">
            <span class="icon">📊</span> Dashboard
        </a>
        <a href="manage_drivers.jsp">
            <span class="icon">👤</span> Manage Drivers
        </a>
        <a href="manage_customers.jsp">
            <span class="icon">👥</span> Manage Customers
        </a>
        <a href="manage_vehicles.jsp">
            <span class="icon">🚖</span> Manage Vehicles
        </a>
        <a href="manage_reservations.jsp">
            <span class="icon">📝</span> Manage Reservations
        </a>

        <a href="#" onclick="logout();">
            <span class="icon">🚪</span> Logout
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="header">
        <button class="toggle-btn" id="toggleBtn">☰</button>
        <div class="user-info">
            <div class="user-avatar"><%= (user != null) ? user.getEmail().substring(0,1).toUpperCase() : "A" %></div>
            <span class="user-name"><%= (user != null) ? user.getEmail() : "Guest" %></span>
        </div>
    </div>

    <!-- Dashboard Cards -->
    <div class="card-container">
        <div class="card card-drivers">
            <div class="card-header">
                <div class="card-icon">👤</div>
            </div>
            <div class="card-value">24</div>
            <div class="card-label">Active Drivers</div>
        </div>

        <div class="card card-vehicles">
            <div class="card-header">
                <div class="card-icon">🚖</div>
            </div>
            <div class="card-value">35</div>
            <div class="card-label">Available Vehicles</div>
        </div>

        <div class="card card-bookings">
            <div class="card-header">
                <div class="card-icon">📝</div>
            </div>
            <div class="card-value">128</div>
            <div class="card-label">Today's Bookings</div>
        </div>

        <div class="card card-revenue">
            <div class="card-header">
                <div class="card-icon">💰</div>
            </div>
            <div class="card-value">LKR 45,250</div>
            <div class="card-label">Today's Revenue</div>
        </div>
    </div>

    <!-- Recent Bookings Section -->
    <div class="section">
        <div class="section-header">
            <h3 class="section-title">Recent Reservations</h3>
            <a href="manage_reservations.jsp" class="btn btn-primary">View All</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Pickup</th>
                    <th>Dropoff</th>
                    <th>Date & Time</th>
                    <th>Status</th>

                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#12350</td>
                    <td>John Doe</td>
                    <td>Colombo Fort</td>
                    <td>Nugegoda</td>
                    <td>Mar 7, 2025 14:30</td>
                    <td><span class="status status-active">Active</span></td>

                </tr>
                <tr>
                    <td>#12349</td>
                    <td>Jane Smith</td>
                    <td>Bambalapitiya</td>
                    <td>Colombo Airport</td>
                    <td>Mar 7, 2025 12:15</td>
                    <td><span class="status status-completed">Completed</span></td>

                </tr>
                <tr>
                    <td>#12348</td>
                    <td>Robert Johnson</td>
                    <td>Dehiwala</td>
                    <td>Colombo 7</td>
                    <td>Mar 7, 2025 10:00</td>
                    <td><span class="status status-pending">Pending</span></td>

                </tr>
                <tr>
                    <td>#12347</td>
                    <td>Mary Williams</td>
                    <td>Kollupitiya</td>
                    <td>Mount Lavinia</td>
                    <td>Mar 7, 2025 09:45</td>
                    <td><span class="status status-assigned">Assigned</span></td>

                </tr>
                <tr>
                    <td>#12346</td>
                    <td>David Brown</td>
                    <td>Wellawatte</td>
                    <td>Rajagiriya</td>
                    <td>Mar 7, 2025 08:30</td>
                    <td><span class="status status-cancelled">Cancelled</span></td>

                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        fetchDashboardSummary();
        fetchRecentReservations();
        setupSidebarToggle();
        setupNavigation();
    });

    function fetchDashboardSummary() {
        fetch('/report/overall')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                document.querySelector('.card-drivers .card-value').textContent = data.driverCount;
                document.querySelector('.card-vehicles .card-value').textContent = data.vehicleCount;
                document.querySelector('.card-bookings .card-value').textContent = data.reservationCount;
                document.querySelector('.card-revenue .card-value').textContent = 'LKR ' + data.totalIncome.toLocaleString();
            })
            .catch(error => {
                console.error('Error fetching dashboard summary:', error);
                showErrorNotification('Failed to load dashboard data');
            });
    }

    function fetchRecentReservations() {
        fetch('/reservation/admin/all')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(reservations => {
                const tableBody = document.querySelector('.table-container table tbody');
                tableBody.innerHTML = ''; // Clear existing rows

                reservations.forEach(reservation => {
                    const row = document.createElement('tr');

                    // Format the date
                    const reservationDate = new Date(reservation.datetime);
                    const formattedDate = reservationDate.toLocaleDateString('en-US', {
                        month: 'short',
                        day: 'numeric',
                        year: 'numeric'
                    });
                    const formattedTime = reservationDate.toLocaleTimeString('en-US', {
                        hour: '2-digit',
                        minute: '2-digit'
                    });

                    // Create row content
                    row.innerHTML =
                        '<td>#' + reservation.id + '</td>' +
                        '<td>' + reservation.customer + '</td>' +
                        '<td>' + reservation.pickupLocation + '</td>' +
                        '<td>' + reservation.dropOffLocation + '</td>' +
                        '<td>' + formattedDate + ' ' + formattedTime + '</td>' +
                        '<td><span class="status status-' + reservation.status.toLowerCase() + '">' + reservation.status + '</span></td>';

                    tableBody.appendChild(row);
                });
            })
            .catch(error => {
                console.error('Error fetching recent reservations:', error);
                showErrorNotification('Failed to load reservation data');
            });
    }

    function setupSidebarToggle() {
        const toggleBtn = document.getElementById('toggleBtn');
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');

        toggleBtn.addEventListener('click', function () {
            sidebar.classList.toggle('active');
            mainContent.classList.toggle('active');
        });
    }

    function setupNavigation() {
        document.querySelectorAll('.sidebar-menu a').forEach(link => {
            link.addEventListener('click', function (e) {
                // Only prevent default if it's a dummy link (#)
                if (this.getAttribute('href') === '#') {
                    e.preventDefault();
                }

                // Remove active class from all links
                document.querySelectorAll('.sidebar-menu a').forEach(item => {
                    item.classList.remove('active');
                });

                // Add active class to clicked link
                this.classList.add('active');
            });
        });
    }

    function showErrorNotification(message) {
        // Create notification element if it doesn't exist
        let notification = document.querySelector('.notification');
        if (!notification) {
            notification = document.createElement('div');
            notification.className = 'notification';
            document.body.appendChild(notification);
        }

        notification.textContent = message;
        notification.classList.add('show');

        // Hide after 5 seconds
        setTimeout(() => {
            notification.classList.remove('show');
        }, 5000);
    }

    function refreshDashboard() {
        fetchDashboardSummary();
        fetchRecentReservations();
    }
</script>
<script src="../assets/js/script.js"></script>
</body>

</html>