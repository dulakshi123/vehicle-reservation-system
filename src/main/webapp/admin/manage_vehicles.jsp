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
    <title>Mega City Cab - Manage Vehicles</title>
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

        .status-available {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success);
        }

        .status-maintenance {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning);
        }

        .status-trip {
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

        .edit-btn {
            background-color: var(--warning);
        }

        .action-btn:hover {
            opacity: 0.8;
        }

        /* Form Styles */
        .form-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            background-color: white;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 200;
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
            padding: 20px;
            border-radius: 8px;
            width: 50%;
            max-width: 500px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 600;
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

        /* Status Badge Filter */
        .filter-container {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .filter-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            border: 2px solid transparent;
        }

        .filter-badge.active {
            border-color: var(--dark);
        }

        .filter-all {
            background-color: #f8f9fa;
        }

        .filter-available {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success);
        }

        .filter-maintenance {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning);
        }

        .filter-trip {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
        }

        /* Responsive design */
        @media (max-width: 1200px) {
            .form-container {
                grid-template-columns: 1fr;
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

            .modal-content {
                width: 90%;
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
        <a href="manage_vehicles.jsp" class="active">
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

    <!-- Add Vehicle Section -->
    <div class="section">
        <div class="section-header">
            <h3 class="section-title">Add New Vehicle</h3>
        </div>

        <form id="addVehicleForm">
            <div class="form-container">
                <div class="form-group">
                    <label class="form-label" for="plateNumber">Plate Number</label>
                    <input type="text" class="form-control" id="plateNumber" placeholder="CAB-1234" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="model">Vehicle Model</label>
                    <select class="form-select" id="model" required>
                        <option value="">Select Model</option>
                        <option value="ECONOMY">Economy</option>
                        <option value="COMFORT">Comfort</option>
                        <option value="VAN">Van</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn btn-success">Add Vehicle</button>
        </form>
    </div>

    <!-- All Vehicles Section -->
    <div class="section">
        <div class="section-header">
            <h3 class="section-title">All Vehicles</h3>
            <div class="search-box">
                <input type="text" id="searchVehicle" class="form-control" placeholder="Search vehicles...">
            </div>
        </div>

        <!-- Filter options -->
        <div class="filter-container">
            <div class="filter-badge filter-all active" data-filter="all">All</div>
            <div class="filter-badge filter-available" data-filter="available">Available</div>
            <div class="filter-badge filter-maintenance" data-filter="maintenance">Under Maintenance</div>
            <div class="filter-badge filter-trip" data-filter="trip">On Trip</div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Plate Number</th>
                    <th>Model</th>
                    <th>Seat Count</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="vehiclesTableBody">
                <!-- Vehicle rows will be dynamically populated here -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Edit Vehicle Modal -->
    <div id="editVehicleModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Edit Vehicle</h3>
                <span class="close">&times;</span>
            </div>

            <form id="editVehicleForm">
                <input type="hidden" id="editVehicleId">

                <div class="form-group">
                    <label class="form-label" for="editPlateNumber">Plate Number</label>
                    <input type="text" class="form-control" id="editPlateNumber" required disabled>
                </div>

                <div class="form-group">
                    <label class="form-label" for="editModel">Vehicle Model</label>
                    <input type="text" class="form-control" id="editModel" required disabled>
                </div>

                <div class="form-group">
                    <label class="form-label" for="editSeatCount">Seat Count</label>
                    <input type="number" class="form-control" id="editSeatCount" min="2" max="10" required disabled>
                </div>

                <div class="form-group">
                    <label class="form-label" for="editStatus">Vehicle Status</label>
                    <select class="form-select" id="editStatus" required>
                        <option value="AVAILABLE">Available</option>
                        <option value="ON_TRIP">On Trip</option>
                        <option value="UNDER_MAINTENANCE">Under Maintenance</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Update Vehicle</button>
            </form>
        </div>
    </div>

    <script>
        // Define vehicles data store
        let vehicles = [];

        async function fetchVehicles() {
            try {
                const response = await fetch('../vehicle/all');
                if (!response.ok) {
                    throw new Error('Failed to fetch vehicles data');
                }
                vehicles = await response.json();
                renderVehiclesTable();
            } catch (error) {
                console.error('Error fetching vehicles:', error);
                alert('Failed to load vehicles. Please try again later.');
            }
        }

        function renderVehiclesTable(vehiclesToRender = vehicles) {
            const tableBody = document.getElementById('vehiclesTableBody');
            tableBody.innerHTML = '';

            vehiclesToRender.forEach(vehicle => {
                const row = document.createElement('tr');

                // Create status class based on vehicle status
                let statusClass = '';
                let statusText = '';

                switch (vehicle.status) {
                    case 'AVAILABLE':
                        statusClass = 'status-available';
                        statusText = 'Available';
                        break;
                    case 'UNDER_MAINTENANCE':
                        statusClass = 'status-maintenance';
                        statusText = 'Under Maintenance';
                        break;
                    case 'ON_TRIP':
                        statusClass = 'status-trip';
                        statusText = 'On Trip';
                        break;
                }

                row.innerHTML =
                    '<td>' + vehicle.id + '</td>' +
                    '<td>' + vehicle.vrn + '</td>' +
                    '<td>' + vehicle.type + '</td>' +
                    '<td>' + vehicle.seatCount + '</td>' +
                    '<td><span class="status ' + statusClass + '">' + statusText + '</span></td>' +
                    '<td>' +
                    '<div class="action-btns">' +
                    '<a href="#" class="action-btn edit-btn" data-id="' + vehicle.id + '">✏</a>' +
                    '</div>' +
                    '</td>';

                tableBody.appendChild(row);
            });

            // Re-attach event listeners to edit buttons
            attachEditButtonListeners();
        }

        function findVehicleById(id) {
            return vehicles.find(vehicle => vehicle.id === parseInt(id));
        }

        function attachEditButtonListeners() {
            const editBtns = document.querySelectorAll('.edit-btn');

            editBtns.forEach(btn => {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    const vehicleId = this.getAttribute('data-id');
                    const vehicle = findVehicleById(vehicleId);

                    if (vehicle) {
                        document.getElementById('editVehicleId').value = vehicle.id;
                        document.getElementById('editPlateNumber').value = vehicle.vrn;
                        document.getElementById('editModel').value = vehicle.type;
                        document.getElementById('editSeatCount').value = vehicle.seatCount;
                        document.getElementById('editStatus').value = vehicle.status;

                        // Display modal
                        document.getElementById('editVehicleModal').style.display = 'block';
                    }
                });
            });
        }

        function filterVehicles(filter) {
            if (filter === 'all') {
                renderVehiclesTable();
                return;
            }

            let filteredVehicles;

            switch (filter) {
                case 'available':
                    filteredVehicles = vehicles.filter(v => v.status === 'AVAILABLE');
                    break;
                case 'maintenance':
                    filteredVehicles = vehicles.filter(v => v.status === 'UNDER_MAINTENANCE');
                    break;
                case 'trip':
                    filteredVehicles = vehicles.filter(v => v.status === 'ON_TRIP');
                    break;
                default:
                    filteredVehicles = vehicles;
            }

            renderVehiclesTable(filteredVehicles);
        }

        function searchVehicles(query) {
            query = query.toLowerCase().trim();

            if (!query) {
                renderVehiclesTable();
                return;
            }

            const filteredVehicles = vehicles.filter(v =>
                v.vrn.toLowerCase().includes(query) ||
                v.type.toLowerCase().includes(query)
            );

            renderVehiclesTable(filteredVehicles);
        }

        async function addVehicle(vehicleData) {
            try {
                const response = await fetch('../vehicle/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(vehicleData)
                });

                if (!response.ok) {
                    throw new Error('Failed to add vehicle');
                }

                const newVehicle = await response.json();
                vehicles.push(newVehicle);
                renderVehiclesTable();
                return true;
            } catch (error) {
                console.error('Error adding vehicle:', error);
                alert('Failed to add vehicle. Please try again.');
                return false;
            }
        }

        async function updateVehicleStatus(id, status) {
            try {
                const response = await fetch('../vehicle/update?id=' + id + '&status=' + status, {
                    method: 'PUT',
                });

                if (!response.ok) {
                    throw new Error('Failed to update vehicle status');
                }

                await response.text();

                // Update in local array
                const index = vehicles.findIndex(v => v.id === parseInt(id));
                if (index !== -1) {
                    vehicles[index].status = status;
                }

                renderVehiclesTable();
                return true;
            } catch (error) {
                console.error('Error updating vehicle status:', error);
                alert('Failed to update vehicle status. Please try again.');
                return false;
            }
        }

        // Toggle sidebar
        const toggleBtn = document.getElementById('toggleBtn');
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');

        toggleBtn.addEventListener('click', function () {
            sidebar.classList.toggle('active');
            mainContent.classList.toggle('active');
        });

        // Add Vehicle Form
        const addVehicleForm = document.getElementById('addVehicleForm');
        addVehicleForm.addEventListener('submit', async function (e) {
            e.preventDefault();

            // Get form values
            const plateNumber = document.getElementById('plateNumber').value;
            const model = document.getElementById('model').value;

            // Create new vehicle object
            const newVehicle = {
                vrn: plateNumber,
                type: model
            };

            // Send to backend
            const success = await addVehicle(newVehicle);

            if (success) {
                // Reset form
                this.reset();
                alert('Vehicle added successfully!');
            }
        });

        // Edit Vehicle Form
        const editVehicleForm = document.getElementById('editVehicleForm');
        editVehicleForm.addEventListener('submit', async function (e) {
            e.preventDefault();

            const vehicleId = parseInt(document.getElementById('editVehicleId').value);
            const updatedStatus = document.getElementById('editStatus').value;

            // Send to backend
            const success = await updateVehicleStatus(vehicleId, updatedStatus);

            if (success) {
                // Close modal
                document.getElementById('editVehicleModal').style.display = 'none';
                alert('Vehicle updated successfully!');
            }
        });

        // Close modal when clicking the x
        document.querySelector('.close').addEventListener('click', function () {
            document.getElementById('editVehicleModal').style.display = 'none';
        });

        // Close modal when clicking outside the modal
        window.addEventListener('click', function (event) {
            const modal = document.getElementById('editVehicleModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Filter vehicles
        const filterBadges = document.querySelectorAll('.filter-badge');
        filterBadges.forEach(badge => {
            badge.addEventListener('click', function () {
                // Remove active class from all badges
                filterBadges.forEach(b => b.classList.remove('active'));

                // Add active class to clicked badge
                this.classList.add('active');

                // Get filter value and apply filter
                const filter = this.getAttribute('data-filter');
                filterVehicles(filter);
            });
        });

        // Search functionality
        const searchInput = document.getElementById('searchVehicle');
        searchInput.addEventListener('input', function () {
            searchVehicles(this.value);
        });

        // Initialize the table on page load
        document.addEventListener('DOMContentLoaded', function () {
            fetchVehicles();
        });
    </script>
    <script src="../assets/js/script.js"></script>
</div>
</body>
</html>