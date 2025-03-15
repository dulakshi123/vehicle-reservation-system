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
    <title>Mega City Cab - Manage Drivers</title>
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

        .page-title {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-label {
            font-weight: 500;
        }

        .filter-input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
        }

        .filter-input:focus {
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

        .status-inactive {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
        }

        .status-on_trip {
            background-color: rgba(52, 152, 219, 0.1);
            color: var(--accent);
        }

        .status-available {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning);
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

        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            gap: 5px;
        }

        .page-item {
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            user-select: none;
        }

        .page-item.active {
            background-color: var(--accent);
            color: white;
            border-color: var(--accent);
        }

        .page-item:hover:not(.active) {
            background-color: #f1f1f1;
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
            border-radius: 10px;
            width: 100%;
            max-width: 600px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 600;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--gray);
        }

        .close-btn:hover {
            color: var(--danger);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            border-color: var(--accent);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .btn-light {
            background-color: #f8f9fa;
            color: var(--text);
            border: 1px solid #ddd;
        }

        .btn-light:hover {
            background-color: #e9ecef;
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
                grid-template-columns: 1fr;
            }

            .filters {
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
        <a href="manage_drivers.jsp" class="active">
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

    <div class="page-title">
        <h1>Manage Drivers</h1>
        <button class="btn btn-primary" id="addDriverBtn">Add New Driver</button>
    </div>

    <div class="section">
        <div class="section-header">
            <h3 class="section-title">Driver List</h3>
        </div>

        <div class="filters">
            <div class="filter-item">
                <span class="filter-label">Search:</span>
                <input type="text" id="searchInput" class="filter-input" placeholder="Name, ID, Mobile...">
            </div>

            <div class="filter-item">
                <span class="filter-label">Status:</span>
                <select id="statusFilter" class="filter-input">
                    <option value="all">All Status</option>
                    <option value="AVAILABLE">Available</option>
                    <option value="ON_TRIP">On Trip</option>
                </select>
            </div>
        </div>

        <div class="table-container">
            <table id="driversTable">
                <thead>
                <tr>
                    <th>Reg ID</th>
                    <th>Name</th>
                    <th>Mobile</th>
                    <th>DLN</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <div class="page-item">«</div>
            <div class="page-item active">1</div>

            <div class="page-item">»</div>
        </div>
    </div>
</div>

<!-- Add Driver Modal -->
<div class="modal" id="addDriverModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Add New Driver</h3>
            <button class="close-btn" id="closeAddModalBtn">&times;</button>
        </div>

        <form id="addDriverForm">
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Registration ID</label>
                    <input type="text" class="form-input" placeholder="e.g. DRV008" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-input" placeholder="Full Name" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Mobile</label>
                    <input type="text" class="form-input" placeholder="e.g. 07XXXXXXXX" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Driver's License Number</label>
                    <input type="text" class="form-input" placeholder="e.g. DLXXXXXXXX" required>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" id="cancelAddBtn">Cancel</button>
                <button type="submit" class="btn btn-success">Add Driver</button>
            </div>
        </form>
    </div>
</div>

<!-- Update Driver Modal -->
<div class="modal" id="updateDriverModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Update Driver</h3>
            <button class="close-btn" id="closeUpdateModalBtn">&times;</button>
        </div>

        <form id="updateDriverForm">
            <input type="hidden" id="updateDriverId">
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Registration ID</label>
                    <input type="text" id="updateRegId" class="form-input" disabled>
                </div>
                <div class="form-group">
                    <label class="form-label">Name</label>
                    <input type="text" id="updateName" class="form-input" disabled>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Mobile</label>
                    <input type="text" id="updateMobile" class="form-input" disabled>
                </div>
                <div class="form-group">
                    <label class="form-label">Driver's License Number</label>
                    <input type="text" id="updateDLN" class="form-input" disabled>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <select id="updateStatus" class="form-input">
                        <option value="AVAILABLE">Available</option>
                        <option value="ON_TRIP">On Trip</option>
                    </select>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" id="cancelUpdateBtn">Cancel</button>
                <button type="submit" class="btn btn-success">Update Driver</button>
            </div>
        </form>
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

    // Make sidebar links work
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

    document.addEventListener('DOMContentLoaded', function () {
        fetchDrivers();
    });

    // Variables for pagination
    let currentPage = 1;
    let totalPages = 1;
    let driversPerPage = 10;

    // Add Driver Modal functionality
    const addDriverBtn = document.getElementById('addDriverBtn');
    const addDriverModal = document.getElementById('addDriverModal');
    const closeAddModalBtn = document.getElementById('closeAddModalBtn');
    const cancelAddBtn = document.getElementById('cancelAddBtn');

    addDriverBtn.addEventListener('click', function () {
        addDriverModal.classList.add('active');
    });

    closeAddModalBtn.addEventListener('click', function () {
        addDriverModal.classList.remove('active');
    });

    cancelAddBtn.addEventListener('click', function () {
        addDriverModal.classList.remove('active');
    });

    // Update Driver Modal functionality
    const updateDriverModal = document.getElementById('updateDriverModal');
    const closeUpdateModalBtn = document.getElementById('closeUpdateModalBtn');
    const cancelUpdateBtn = document.getElementById('cancelUpdateBtn');

    closeUpdateModalBtn.addEventListener('click', function () {
        updateDriverModal.classList.remove('active');
    });

    cancelUpdateBtn.addEventListener('click', function () {
        updateDriverModal.classList.remove('active');
    });

    // Close modals when clicking outside
    window.addEventListener('click', function (e) {
        if (e.target === addDriverModal) {
            addDriverModal.classList.remove('active');
        }
        if (e.target === updateDriverModal) {
            updateDriverModal.classList.remove('active');
        }
    });

    // Search and filter functionality
    const searchInput = document.getElementById('searchInput');
    const statusFilter = document.getElementById('statusFilter');
    const driversTable = document.getElementById('driversTable');

    function fetchDrivers() {
        const searchText = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;

        // Create query parameters
        const params = new URLSearchParams();
        if (searchText) {
            params.append('search', searchText);
        }
        if (statusValue !== 'all') {
            params.append('status', statusValue);
        }
        params.append('page', currentPage - 1); // API typically uses 0-based indexing
        params.append('size', driversPerPage);

        // Make API call to fetch filtered drivers
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
                console.log(data.length);
                // Update the table with the received data
                updateDriversTable(data);
                // Update pagination
                totalPages = Math.ceil(data.length / driversPerPage);
                updatePagination();
            })
            .catch(error => {
                console.error('Error fetching drivers:', error);
                alert('Failed to load drivers. Please try again later.');
            });
    }

    function updateDriversTable(drivers) {
        const tbody = driversTable.querySelector('tbody');
        tbody.innerHTML = ''; // Clear existing rows

        if (drivers.length === 0) {
            const row = document.createElement('tr');
            row.innerHTML = '<td colspan="6" style="text-align: center;">No drivers found</td>';
            tbody.appendChild(row);
            return;
        }

        drivers.forEach(driver => {
            const row = document.createElement('tr');
            row.dataset.id = driver.id;

            // Determine status class
            let statusClass = 'status-active';
            if (driver.status === 'ON_TRIP') {
                statusClass = 'status-on_trip';
            } else if (driver.status === 'AVAILABLE') {
                statusClass = 'status-active';
            } else if (driver.status === 'INACTIVE') {
                statusClass = 'status-inactive';
            }

            const driverData = {
                id: driver.id,
                regId: driver.regId,
                name: driver.name,
                mobile: driver.mobile,
                dln: driver.dln,
                status: driver.status
            }

            row.innerHTML =
                '<td>' + driver.regId + '</td>' +
                '<td>' + driver.name + '</td>' +
                '<td>' + driver.mobile + '</td>' +
                '<td>' + driver.dln + '</td>' +
                '<td><span class="status ' + statusClass + '">' + driver.status + '</span></td>' +
                '<td>' +
                '<div class="action-btns">' +
                '<a href="#" class="action-btn edit-btn" data-driver=\'' + JSON.stringify(driverData) + '\' data-id="' + driver.id + '">✏</a>' +
                '</div>' +
                '</td>';


            tbody.appendChild(row);
        });

        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', function(event) {
                const driver = JSON.parse(this.dataset.driver);
                handleEditClick(event, driver);
            });
        });
    }

    function updatePagination() {
        const pagination = document.querySelector('.pagination');
        pagination.innerHTML = '';

        // Previous button
        const prevBtn = document.createElement('div');
        prevBtn.className = 'page-item';
        prevBtn.textContent = '«';
        prevBtn.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                fetchDrivers();
            }
        });
        pagination.appendChild(prevBtn);

        // Page numbers
        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement('div');
            pageItem.className = 'page-item';
            if (i === currentPage) {
                pageItem.classList.add('active');
            }
            pageItem.textContent = i;
            pageItem.addEventListener('click', () => {
                currentPage = i;
                fetchDrivers();
            });
            pagination.appendChild(pageItem);
        }

        // Next button
        const nextBtn = document.createElement('div');
        nextBtn.className = 'page-item';
        nextBtn.textContent = '»';
        nextBtn.addEventListener('click', () => {
            if (currentPage < totalPages) {
                currentPage++;
                fetchDrivers();
            }
        });
        pagination.appendChild(nextBtn);
    }

    // Event listeners for search and filter
    function filterTable() {
        const searchText = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;

        const rows = driversTable.querySelectorAll('tbody tr');

        rows.forEach(row => {
            const regId = row.cells[0].textContent.toLowerCase();
            const name = row.cells[1].textContent.toLowerCase();
            const mobile = row.cells[2].textContent.toLowerCase();
            const dln = row.cells[3].textContent.toLowerCase();
            const status = row.cells[4].textContent.trim();

            const matchesSearch = regId.includes(searchText) ||
                name.includes(searchText) ||
                mobile.includes(searchText) ||
                dln.includes(searchText);

            const matchesStatus = statusValue === 'all' || status === statusValue;

            row.style.display = (matchesSearch && matchesStatus) ? '' : 'none';
        });
    }

    searchInput.addEventListener('keyup', filterTable);
    statusFilter.addEventListener('change', filterTable);

    // Add driver functionality
    const addDriverForm = document.getElementById('addDriverForm');
    addDriverForm.addEventListener('submit', function (e) {
        e.preventDefault();

        // Get form data
        const formElements = this.elements;
        const driverData = {
            regId: formElements[0].value,
            name: formElements[1].value,
            mobile: formElements[2].value,
            dln: formElements[3].value
        };

        // Send data to server
        fetch('../driver/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(driverData)
        })
        .then(response => {
            return response.text();
        })
        .then(data => {
            // Show success message
            alert(data);

            // Reset form and close modal
            addDriverForm.reset();
            addDriverModal.classList.remove('active');

            // Refresh the drivers list
            fetchDrivers();
        })
        .catch(error => {
            console.error('Error adding driver:', error);
            alert('Failed to add driver. Please try again.');
        });
    });

    // Handle edit button click
    function handleEditClick(e, driver) {
        e.preventDefault();

        document.getElementById('updateDriverId').value = driver.id;
        document.getElementById('updateRegId').value = driver.regId;
        document.getElementById('updateName').value = driver.name;
        document.getElementById('updateMobile').value = driver.mobile;
        document.getElementById('updateDLN').value = driver.dln;
        document.getElementById('updateStatus').value = driver.status;

        // Show the update modal
        updateDriverModal.classList.add('active');
    }

    // Handle update driver form submission
    const updateDriverForm = document.getElementById('updateDriverForm');
    updateDriverForm.addEventListener('submit', function (e) {
        e.preventDefault();

        const driverId = document.getElementById('updateDriverId').value;
        const newStatus = document.getElementById('updateStatus').value;

        // Send update to server
        fetch('../driver/update?id=' + driverId + '&status=' + newStatus, {
            method: 'PUT',
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to update driver');
                }
                return response.text();
            })
            .then(data => {
                // Show success message
                alert('Driver status updated successfully!');

                // Close the modal
                updateDriverModal.classList.remove('active');

                // Refresh the drivers list
                fetchDrivers();
            })
            .catch(error => {
                console.error('Error updating driver:', error);
                alert('Failed to update driver. Please try again.');
            });
    });
</script>
<script src="../assets/js/script.js"></script>
</body>

</html>