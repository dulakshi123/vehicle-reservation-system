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
    <title>Mega City Cab - Manage Customers</title>
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

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 600;
            color: var(--dark);
        }

        .btn {
            padding: 8px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
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

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .card-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
        }

        .card-body {
            padding: 20px;
        }

        .search-export {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
            max-width: 500px;
        }

        .search-input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }

        .export-buttons {
            display: flex;
            gap: 10px;
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
            vertical-align: middle;
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

        .status-inactive {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
        }

        .status-pending {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning);
        }

        .action-btns {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            width: 32px;
            height: 32px;
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

        .pagination {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .pagination-info {
            color: var(--gray);
        }

        .pagination-controls {
            display: flex;
            gap: 5px;
        }

        .pagination-btn {
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 5px;
            border: 1px solid #ddd;
            background-color: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn.active {
            background-color: var(--accent);
            color: white;
            border-color: var(--accent);
        }

        .pagination-btn:hover:not(.active) {
            background-color: #f8f9fa;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 0;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 600px;
            animation: modalSlideIn 0.3s ease;
        }

        @keyframes modalSlideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
        }

        .close {
            color: var(--gray);
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: var(--dark);
        }

        .modal-body {
            padding: 20px;
        }

        .customer-details {
            margin-bottom: 20px;
        }

        .detail-group {
            display: flex;
            margin-bottom: 15px;
        }

        .detail-label {
            font-weight: 600;
            width: 150px;
            color: var(--dark);
        }

        .detail-value {
            flex: 1;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
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

            .search-export {
                flex-direction: column;
                gap: 10px;
            }

            .search-bar {
                max-width: 100%;
            }

            .detail-group {
                flex-direction: column;
                gap: 5px;
            }

            .detail-label {
                width: 100%;
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
        <a href="manage_customers.jsp" class="active">
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
            <div class="user-avatar"><%= (user != null) ? user.getEmail().substring(0, 1).toUpperCase() : "A" %>
            </div>
            <span class="user-name"><%= (user != null) ? user.getEmail() : "Guest" %></span>
        </div>
    </div>

    <div class="page-header">
        <h1 class="page-title">Manage Customers</h1>
    </div>

    <div class="card">
        <div class="card-header">
            <h2 class="card-title">Customer List</h2>
        </div>
        <div class="card-body">
            <div class="search-export">
                <div class="search-bar">
                    <input type="text" class="search-input" placeholder="Search customers..." id="searchInput">
                    <button class="btn btn-primary" id="searchBtn">Search</button>
                </div>
            </div>

            <div class="table-container">
                <table id="customersTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Reg ID</th>
                        <th>Name</th>
                        <th>Mobile</th>
                        <th>Email</th>
                        <th>NIC</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Dummy data representing what would come from Spring Boot backend -->
                    <tr>
                        <td>1</td>
                        <td>CUST-00001</td>
                        <td>John Doe</td>
                        <td>0771234567</td>
                        <td>john.doe@email.com</td>
                        <td>901234567V</td>
                        <td>
                            <div class="action-btns">
                                <a class="action-btn view-btn view-customer" data-id="1">👁️</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>CUST-00002</td>
                        <td>Jane Smith</td>
                        <td>0772345678</td>
                        <td>jane.smith@email.com</td>
                        <td>912345678V</td>
                        <td>
                            <div class="action-btns">
                                <a class="action-btn view-btn view-customer" data-id="2">👁️</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>CUST-00003</td>
                        <td>Sunil Perera</td>
                        <td>0773456789</td>
                        <td>sunil.perera@email.com</td>
                        <td>923456789V</td>
                        <td>
                            <div class="action-btns">
                                <a class="action-btn view-btn view-customer" data-id="3">👁️</a>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <div class="pagination-info">
                    Showing 1 to 3 of 3 entries
                </div>
                <div class="pagination-controls">
                    <button class="pagination-btn">«</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">»</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- View Customer Modal -->
<div id="viewCustomerModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Customer Details</h2>
            <span class="close">&times;</span>
        </div>
        <div class="modal-body">
            <div class="customer-details">
                <div class="detail-group">
                    <div class="detail-label">Customer ID:</div>
                    <div class="detail-value" id="customerId">CUST-00001</div>
                </div>
                <div class="detail-group">
                    <div class="detail-label">Name:</div>
                    <div class="detail-value" id="customerName">John Doe</div>
                </div>
                <div class="detail-group">
                    <div class="detail-label">Email:</div>
                    <div class="detail-value" id="customerEmail">john.doe@email.com</div>
                </div>
                <div class="detail-group">
                    <div class="detail-label">Mobile:</div>
                    <div class="detail-value" id="customerMobile">0771234567</div>
                </div>
                <div class="detail-group">
                    <div class="detail-label">NIC:</div>
                    <div class="detail-value" id="customerNic">901234567V</div>
                </div>
                <div class="detail-group">
                    <div class="detail-label">Address:</div>
                    <div class="detail-value" id="customerAddress">123 Main Street, Colombo 05</div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" id="closeViewModal">Close</button>
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

    // Search functionality (preserved as requested)
    const searchInput = document.getElementById('searchInput');
    const searchBtn = document.getElementById('searchBtn');
    const customersTable = document.getElementById('customersTable');

    searchBtn.addEventListener('click', function () {
        const searchTerm = searchInput.value.toLowerCase();
        const rows = customersTable.querySelectorAll('tbody tr');

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    searchInput.addEventListener('keyup', function (e) {
        if (e.key === 'Enter') {
            searchBtn.click();
        }
    });

    // Modal functionality
    const viewCustomerModal = document.getElementById('viewCustomerModal');
    const deleteConfirmModal = document.getElementById('deleteConfirmModal');
    const closeButtons = document.querySelectorAll('.close');

    let customersList = [];

    // Function to load all customers from the backend
    function loadCustomers() {
        fetch('../customer/all', {
            method: 'GET'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(customers => {
            customersList = customers;
            displayCustomers();
        })
        .catch(error => {
            console.error('Error fetching customers:', error);
            alert('Failed to load customers. Please try again later.');
        });
    }

    // Function to display customers in the table
    function displayCustomers() {
        const tableBody = document.querySelector('#customersTable tbody');
        tableBody.innerHTML = ''; // Clear existing rows

        if (customersList.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="7" style="text-align: center;">No customers found</td></tr>';
            return;
        }

        customersList.forEach(customer => {
            const row = document.createElement('tr');
            row.innerHTML =
                '<td>' + customer.id + '</td>' +
                '<td>' + (customer.regId ? customer.regId : '-') + '</td>' +
                '<td>' + customer.name + '</td>' +
                '<td>' + customer.mobile + '</td>' +
                '<td>' + customer.email + '</td>' +
                '<td>' + customer.nic + '</td>' +
                '<td>' +
                '<div class="action-btns">' +
                '<a class="action-btn view-btn view-customer" data-id="' + customer.id + '">👁</a>' +
                '</div>' +
                '</td>';

            tableBody.appendChild(row);
        });

        // Attach event listeners to the new view buttons
        attachViewCustomerListeners();
    }

    // Function to attach event listeners to view buttons
    function attachViewCustomerListeners() {
        document.querySelectorAll('.view-customer').forEach(btn => {
            btn.addEventListener('click', function () {
                const customerId = this.getAttribute('data-id');
                viewCustomerDetails(customerId);
            });
        });
    }

    // Function to view customer details
    function viewCustomerDetails(customerId) {
        const customer = customersList.find(c => c.id = customerId);

        if(!customer) {
            alert("Failed to fetch customer details");
            return;
        }

        // Update modal with customer details
        document.getElementById('customerId').textContent = customer.regId || '-';
        document.getElementById('customerName').textContent = customer.name || '-';
        document.getElementById('customerEmail').textContent = customer.email || '-';
        document.getElementById('customerMobile').textContent = customer.mobile || '-';
        document.getElementById('customerNic').textContent = customer.nic || '-';
        document.getElementById('customerAddress').textContent = customer.address || '-';

        // Show the modal
        viewCustomerModal.style.display = 'block';
    }

    // Helper function to format date
    function formatDate(dateString) {
        if (!dateString) return '-';

        const options = {year: 'numeric', month: 'long', day: 'numeric'};
        return new Date(dateString).toLocaleDateString(undefined, options);
    }

    // Close modals with close button
    closeButtons.forEach(button => {
        button.addEventListener('click', function () {
            viewCustomerModal.style.display = 'none';
            deleteConfirmModal.style.display = 'none';
        });
    });

    // Close view modal with close button
    document.getElementById('closeViewModal').addEventListener('click', function () {
        viewCustomerModal.style.display = 'none';
    });

    // Close modals if clicking outside
    window.addEventListener('click', function (event) {
        if (event.target === viewCustomerModal) {
            viewCustomerModal.style.display = 'none';
        }
        if (event.target === deleteConfirmModal) {
            deleteConfirmModal.style.display = 'none';
        }
    });

    // Load customers when the page is ready
    document.addEventListener('DOMContentLoaded', function () {
        loadCustomers();
    });
</script>
<script src="../assets/js/script.js"></script>
</body>
</html>