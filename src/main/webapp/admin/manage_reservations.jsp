<%@ page import="com.dulakshi.vrs.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("_user_");

    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../assets/img/logo.png">
    <title>Mega City Cab - Manage Reservations</title>
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

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #27ae60;
        }

        .btn-warning {
            background-color: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background-color: #e67e22;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .search-filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-group label {
            font-weight: 500;
        }

        .filter-group select,
        .filter-group input {
            padding: 8px 12px;
            border-radius: 5px;
            border: 1px solid #ddd;
            outline: none;
        }

        .filter-group select:focus,
        .filter-group input:focus {
            border-color: var(--accent);
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
            cursor: pointer;
        }

        thead th.active {
            color: var(--accent);
        }

        thead th.active:after {
            content: ' ↑';
        }

        thead th.active.desc:after {
            content: ' ↓';
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

        .status-booked {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning);
        }

        .status-checked_in {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success);
        }

        .status-cancelled {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
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

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background-color: white;
            width: 100%;
            max-width: 600px;
            border-radius: 8px;
            overflow: hidden;
            max-height: 90vh;
            display: flex;
            flex-direction: column;
        }

        .modal-header {
            padding: 15px 20px;
            background-color: var(--primary);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-weight: 600;
            font-size: 18px;
        }

        .close-modal {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }

        .modal-body {
            padding: 20px;
            overflow-y: auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            outline: none;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--accent);
        }

        .form-group input:disabled {
            background-color: #e6e6e6;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-col {
            flex: 1;
        }

        .modal-footer {
            padding: 15px 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            border-top: 1px solid #eee;
        }

        /* Responsive design */
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

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .search-filters {
                flex-direction: column;
                align-items: flex-start;
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
        <a href="dashboard.jsp">
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
        <a href="manage_reservations.jsp" class="active">
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
            <div class="user-avatar"><%= (user != null) ? user.getEmail().substring(0, 1).toUpperCase() : "A" %>
            </div>
            <span class="user-name"><%= (user != null) ? user.getEmail() : "Guest" %></span>
        </div>
    </div>

    <!-- Reservations Section -->
    <div class="section">
        <div class="section-header">
            <h3 class="section-title">Manage Reservations</h3>
        </div>

        <!-- Search and Filters -->
        <div class="search-filters">
            <div class="filter-group">
                <label for="status-filter">Status:</label>
                <select id="status-filter">
                    <option value="all">All</option>
                    <option value="booked">Booked</option>
                    <option value="checked-in">Checked In</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>

            <div class="filter-group">
                <label for="date-filter">Date:</label>
                <input type="date" id="date-filter">
            </div>

            <div class="filter-group">
                <label for="search">Search:</label>
                <input type="text" id="search" placeholder="ID, Customer, Location...">
            </div>


        </div>

        <div class="table-container">
            <table id="reservations-table">
                <thead>
                <tr>
                    <th data-sort="id">ID</th>
                    <th data-sort="customer">Customer</th>
                    <th data-sort="driver">Driver</th>
                    <th data-sort="vehicle">Vehicle</th>
                    <th data-sort="pickup">Pickup</th>
                    <th data-sort="dropoff">Dropoff</th>
                    <th data-sort="date">Date & Time</th>
                    <th data-sort="passengers">Passengers</th>
                    <th data-sort="fee">Fee (LKR)</th>
                    <th data-sort="status">Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <!-- Sample data -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- View Reservation Modal -->
<div class="modal" id="viewModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Reservation Details</h3>
            <button class="close-modal" onclick="closeModal('viewModal')">&times;</button>
        </div>
        <div class="modal-body">
            <div id="reservation-details">
                <h4>Reservation #12350</h4>
                <div class="form-group">
                    <label>Customer Information:</label>
                    <p>John Doe (Reg ID: CUST-001)</p>
                    <p>Mobile: 0771234567</p>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label>Driver:</label>
                            <p>Kumar Perera (ID: DRV-001)</p>
                            <p>Mobile: 0777123456</p>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label>Vehicle:</label>
                            <p>CAB-1234 (Toyota Prius)</p>
                            <p>Seats: 4</p>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label>Pickup Location:</label>
                            <p>Colombo Fort</p>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label>Dropoff Location:</label>
                            <p>Nugegoda</p>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label>Date & Time:</label>
                            <p>Mar 7, 2025 14:30</p>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label>Passenger Count:</label>
                            <p>2</p>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label>Status:</label>
                            <p><span class="status status-booked">Booked</span></p>
                        </div>
                    </div>
                </div>

                <h4>Payment Details</h4>
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label>Base Fare:</label>
                            <p>LKR 1,400.00</p>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label>Tax (8%):</label>
                            <p>LKR 112.00</p>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label>Discount:</label>
                            <p>LKR 12.00</p>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label>Total Amount:</label>
                            <p>LKR 1,500.00</p>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Payment Status:</label>
                    <p><span class="status status-booked">Pending</span></p>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" onclick="closeModal('viewModal')">Close</button>
        </div>
    </div>
</div>

<!-- Edit Reservation Modal -->
<div class="modal" id="editModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Update Reservation</h3>
            <button class="close-modal" onclick="closeModal('editModal')">&times;</button>
        </div>
        <div class="modal-body">
            <form id="edit-reservation-form">
                <input type="hidden" id="reservation-id" value="#12350">

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="customer">Customer:</label>
                            <input type="text" id="customer" value="John Doe" readonly disabled>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="driver">Assign Driver:</label>
                            <select id="driver">
                                <option value="1" selected>Kumar Perera (Available)</option>
                                <option value="2">Saman Fernando (Available)</option>
                                <option value="3">Nimal Silva (On Break)</option>
                                <option value="4">Chamara Bandara (Available)</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="vehicle">Assign Vehicle:</label>
                            <select id="vehicle">
                                <option value="1" selected>CAB-1234 (Toyota Prius)</option>
                                <option value="2">CAB-2345 (Honda Civic)</option>
                                <option value="3">CAB-3456 (Toyota Corolla)</option>
                                <option value="4">CAB-4567 (Suzuki Alto)</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="status">Status:</label>
                            <select id="status">
                                <option value="BOOKED" selected>Booked</option>
                                <option value="CHECKED_IN">Checked In</option>
                                <option value="CANCELLED">Cancelled</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="pickup">Pickup Location:</label>
                            <input type="text" id="pickup" value="Colombo Fort" readonly disabled>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="dropoff">Dropoff Location:</label>
                            <input type="text" id="dropoff" value="Nugegoda" readonly disabled>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="date">Date:</label>
                            <input type="date" id="date" value="2025-03-07" readonly disabled>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="time">Time:</label>
                            <input type="time" id="time" value="14:30" readonly disabled>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="passengers">Passenger Count:</label>
                            <input type="number" id="passengers" value="2" min="1" readonly disabled>
                        </div>
                    </div>
                </div>

                <h4>Payment Details</h4>
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="fare">Base Fare (LKR):</label>
                            <input type="number" id="fare" value="1400" min="0" step="0.01">
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="tax">Tax (LKR):</label>
                            <input type="number" id="tax" value="112" min="0" step="0.01">
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="discount">Discount (LKR):</label>
                            <input type="number" id="discount" value="12" min="0" step="0.01">
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="payment-status">Payment Status:</label>
                            <select id="payment-status">
                                <option value="PENDING" selected>Pending</option>
                                <option value="PAID">Completed</option>
                            </select>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" onclick="closeModal('editModal')">Cancel</button>
            <button class="btn btn-success" onclick="updateReservation()">Update Reservation</button>
        </div>
    </div>
</div>

<script>
    // Toggle sidebar
    const toggleBtn = document.getElementById('toggleBtn');
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');

    toggleBtn.addEventListener('click', function () {
        sidebar.classList.toggle('active');
        mainContent.classList.toggle('active');
    });

    // Sidebar active state
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

    let reservationData = [];

    document.addEventListener('DOMContentLoaded', function () {
        fetchReservations();
        fetchDrivers();
        fetchVehicles();
    });

    // Fetch all reservations
    function fetchReservations() {
        fetch('../reservation/admin/all', {
            method: 'GET',
            headers: {
                'accept': 'application/json'
            }
        }).then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
            .then(data => {
                reservationData = data;
                renderReservationsTable(reservationData);
            })
            .catch(error => {
                console.error('Error fetching drivers:', error);
                alert('Failed to load drivers. Please try again later.');
            });
    }

    // Render reservations table
    function renderReservationsTable(data) {
        const tableBody = document.querySelector('#reservations-table tbody');
        tableBody.innerHTML = '';

        if (data.length === 0) {
            const noDataRow = document.createElement('tr');
            noDataRow.innerHTML = '<td colspan="11" style="text-align: center;">No reservations found</td>';
            tableBody.appendChild(noDataRow);
            return;
        }

        data.forEach(reservation => {
            const row = document.createElement('tr');
            row.innerHTML =
                '<td>' + reservation.id + '</td>' +
                '<td>' + reservation.customer + '</td>' +
                '<td>' + reservation.driver + '</td>' +
                '<td>' + reservation.vehicle + '</td>' +
                '<td>' + reservation.pickupLocation + '</td>' +
                '<td>' + reservation.dropOffLocation + '</td>' +
                '<td>' + reservation.datetime + '</td>' +
                '<td>' + reservation.passengerCount + '</td>' +
                '<td>' + reservation.payment.toLocaleString() + '</td>' +
                '<td><span class="status status-' + reservation.status.toLowerCase() + '">' + reservation.status + '</span></td>' +
                '<td>' +
                '<div class="action-btns">' +
                '<a href="#" class="action-btn view-btn" data-id="' + reservation.id + '">👁️</a>' +
                '<a href="#" class="action-btn edit-btn" data-id="' + reservation.id + '">✏️</a>' +
                '</div>' +
                '</td>';

            tableBody.appendChild(row);
        });

        // Add event listeners to the newly rendered buttons
        document.querySelectorAll('.view-btn').forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault();
                openViewModal(this.getAttribute('data-id'));
            });
        });

        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault();
                openEditModal(this.getAttribute('data-id'));
            });
        });
    }

    // Search and filter functionality
    function filterReservations() {
        const statusFilter = document.getElementById('status-filter').value;
        const dateFilter = document.getElementById('date-filter').value;
        const searchQuery = document.getElementById('search').value.toLowerCase();

        let filteredData = [...reservationData];

        // Apply status filter
        if (statusFilter !== 'all') {
            filteredData = filteredData.filter(reservation =>
                reservation.status.toLowerCase() === statusFilter
            );
        }

        // Apply date filter
        if (dateFilter) {
            filteredData = filteredData.filter(reservation => {
                return reservation.datetime.substring(0, 10) === dateFilter;
            });
        }

        // Apply search query
        if (searchQuery) {
            filteredData = filteredData.filter(reservation =>
                reservation.customer.toLowerCase().includes(searchQuery) ||
                reservation.driver.toLowerCase().includes(searchQuery) ||
                reservation.pickupLocation.toLowerCase().includes(searchQuery) ||
                reservation.dropOffLocation.toLowerCase().includes(searchQuery)
            );
        }

        renderReservationsTable(filteredData);
    }

    // Add event listeners for filtering
    document.getElementById('status-filter').addEventListener('change', filterReservations);
    document.getElementById('date-filter').addEventListener('change', filterReservations);
    document.getElementById('search').addEventListener('input', filterReservations);

    // Function to find reservation by ID
    function findReservation(id) {
        return reservationData.find(reservation => reservation.id == id);
    }

    // Fetch all drivers
    function fetchDrivers() {
        fetch('../driver/all', {
            method: 'GET',
            headers: {
                'accept': 'application/json'
            }
        }).then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            let optionText = "";
            data.forEach(driver => {
                 optionText += '<option value="'+ driver.id +'">'+ driver.name +' ('+ driver.status.toLowerCase() +')</option>';
            });
            document.getElementById("driver").innerHTML = optionText;
        })
        .catch(error => {
            console.error('Error fetching drivers:', error);
            alert('Failed to load drivers. Please try again later.');
        });
    }

    // Fetch all vehicles
    function fetchVehicles() {
        fetch('../vehicle/all', {
            method: 'GET',
            headers: {
                'accept': 'application/json'
            }
        }).then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            let optionText = "";
            data.forEach(vehicle => {
                optionText += '<option value="'+ vehicle.id +'">'+ vehicle.vrn +' ('+ vehicle.type.toLowerCase() +')</option>';
            });
            document.getElementById("vehicle").innerHTML = optionText;
        })
        .catch(error => {
            console.error('Error fetching vehicles:', error);
            alert('Failed to load vehicles. Please try again later.');
        });
    }

    // Modal functions
    function openViewModal(id) {
        const reservation = findReservation(id);
        if (!reservation) return;

        const modalContent = document.getElementById('reservation-details');
        modalContent.innerHTML =
            '<h4>Reservation ' + reservation.id + '</h4>' +
            '<div class="form-group">' +
            '<label>Customer Information:</label>' +
            '<p>' + reservation.customer + '</p>' +
            '<p>Mobile: ' + reservation.customerMobile + '</p>' +
            '</div>' +

            '<div class="form-row">' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Driver:</label>' +
            '<p>' + reservation.driver + '</p>' +
            '<p>' + reservation.driverMobile + '</p>' +
            '</div>' +
            '</div>' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Vehicle:</label>' +
            '<p>' + reservation.vehicle + '</p>' +
            '<p>' + reservation.seatCount + '</p>' +
            '</div>' +
            '</div>' +
            '</div>' +

            '<div class="form-row">' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Pickup Location:</label>' +
            '<p>' + reservation.pickupLocation + '</p>' +
            '</div>' +
            '</div>' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Dropoff Location:</label>' +
            '<p>' + reservation.dropOffLocation + '</p>' +
            '</div>' +
            '</div>' +
            '</div>' +

            '<div class="form-row">' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Date & Time:</label>' +
            '<p>' + reservation.datetime + '</p>' +
            '</div>' +
            '</div>' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Passenger Count:</label>' +
            '<p>' + reservation.passengerCount + '</p>' +
            '</div>' +
            '</div>' +
            '</div>' +

            '<div class="form-row">' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Status:</label>' +
            '<p><span class="status status-' + reservation.status.toLowerCase().replace(' ', '-') + '">' + reservation.status + '</span></p>' +
            '</div>' +
            '</div>' +
            '</div>' +

            '<h4>Payment Details</h4>' +
            '<div class="form-row">' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Base Fare:</label>' +
            '<p>LKR ' + reservation.fareAmount.toLocaleString() + '</p>' +
            '</div>' +
            '</div>' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Tax (8%):</label>' +
            '<p>LKR ' + reservation.taxAmount.toLocaleString() + '</p>' +
            '</div>' +
            '</div>' +
            '</div>' +

            '<div class="form-row">' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Discount:</label>' +
            '<p>LKR ' + reservation.discount.toLocaleString() + '</p>' +
            '</div>' +
            '</div>' +
            '<div class="form-col">' +
            '<div class="form-group">' +
            '<label>Total Amount:</label>' +
            '<p>LKR ' + reservation.payment.toLocaleString() + '</p>' +
            '</div>' +
            '</div>' +
            '</div>' +

            '<div class="form-group">' +
            '<label>Payment Status:</label>' +
            '<p><span class="status status-' + (reservation.paymentStatus === 'Pending' ? 'booked' : 'checked-in') + '">' + reservation.paymentStatus + '</span></p>' +
            '</div>';

        document.getElementById('viewModal').classList.add('active');
    }

    function openEditModal(id) {
        const reservation = findReservation(id);
        if (!reservation) return;

        // Set form values based on reservation data
        document.getElementById('reservation-id').value = reservation.id;
        document.getElementById('customer').value = reservation.customer;

        document.getElementById('driver').value = reservation.driverId;
        document.getElementById('vehicle').value = reservation.vehicleId;

        // Set status dropdown
        const statusSelect = document.getElementById('status');
        statusSelect.value = reservation.status;

        document.getElementById('pickup').value = reservation.pickupLocation;
        document.getElementById('dropoff').value = reservation.dropOffLocation;

        // Extract date and time from the reservation date string
        const dateTimeParts = reservation.datetime.split(' ');
        const date = dateTimeParts[0];
        const time = dateTimeParts[1].split('.')[0]
        document.getElementById('date').value = date;
        document.getElementById('time').value = time;

        document.getElementById('passengers').value = reservation.passengerCount;
        document.getElementById('fare').value = reservation.fareAmount;
        document.getElementById('tax').value = reservation.taxAmount;
        document.getElementById('discount').value = reservation.discount;

        // Set payment status dropdown
        const paymentStatusSelect = document.getElementById('payment-status');
        paymentStatusSelect.value = reservation.paymentStatus;

        document.getElementById('editModal').classList.add('active');
    }

    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('active');
    }

    function updateReservation() {
        const id = document.getElementById('reservation-id').value;
        const reservation = findReservation(id);
        if (!reservation) return;

        // Update reservation data
        reservation.driverId = document.getElementById('driver').value;
        reservation.vehicleId = document.getElementById('vehicle').value;
        reservation.status = document.getElementById('status').value;

        // Update payment details
        reservation.fareAmount = parseFloat(document.getElementById('fare').value);
        reservation.taxAmount = parseFloat(document.getElementById('tax').value);
        reservation.discount = parseFloat(document.getElementById('discount').value);
        reservation.paymentStatus = document.getElementById('payment-status').value;

        fetch('../reservation/admin/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(reservation),
        }).then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            alert(data);
            fetchReservations();
        })
        .catch(error => {
            console.error('Error updating reservation:', error);
            alert('Failed to update reservation. Please try again later.');
        });
    }

    // Adding event listener for the update button
    document.querySelector('#editModal .btn-success').addEventListener('click', updateReservation);

    // Table sorting functionality
    document.querySelectorAll('#reservations-table th[data-sort]').forEach(th => {
        th.addEventListener('click', function () {
            const sortBy = this.getAttribute('data-sort');
            const isAsc = !this.classList.contains('active') || this.classList.contains('desc');

            // Remove active class from all headers
            document.querySelectorAll('#reservations-table th').forEach(header => {
                header.classList.remove('active', 'desc');
            });

            // Add active class to clicked header
            this.classList.add('active');
            if (!isAsc) {
                this.classList.add('desc');
            }

            // Sort the data
            const sortedData = [...reservationData].sort((a, b) => {
                if (sortBy === 'fee') {
                    return isAsc ? a.fee - b.fee : b.fee - a.fee;
                } else if (sortBy === 'passengers') {
                    return isAsc ? a.passengers - b.passengers : b.passengers - a.passengers;
                } else if (sortBy === 'date') {
                    return isAsc
                        ? new Date(a.date) - new Date(b.date)
                        : new Date(b.date) - new Date(a.date);
                } else {
                    return isAsc
                        ? a[sortBy].localeCompare(b[sortBy])
                        : b[sortBy].localeCompare(a[sortBy]);
                }
            });

            renderReservationsTable(sortedData);
        });
    });

    // Calculate total when fare, tax, or discount changes
    document.getElementById('fare').addEventListener('input', calculateTotal);
    document.getElementById('tax').addEventListener('input', calculateTotal);
    document.getElementById('discount').addEventListener('input', calculateTotal);

    function calculateTotal() {
        const base = parseFloat(document.getElementById('fare').value) || 0;
        const tax = parseFloat(document.getElementById('tax').value) || 0;
        const discount = parseFloat(document.getElementById('discount').value) || 0;
        const total = base + tax - discount;
    }
</script>
<script src="../assets/js/script.js"></script>
</body>
</html>