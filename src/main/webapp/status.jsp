<%@ page import="com.dulakshi.vrs.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("_user_");

    if (user == null) {
        response.sendRedirect("index.jsp");
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - My Reservations</title>
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
            color: var(--dark);
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

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title {
            margin-bottom: 20px;
            color: var(--dark);
        }

        .tab-container {
            margin-bottom: 20px;
        }

        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
        }

        .tab {
            padding: 12px 20px;
            cursor: pointer;
            font-weight: 500;
            border-bottom: 3px solid transparent;
        }

        .tab.active {
            border-bottom-color: var(--primary);
            color: var(--primary);
        }

        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            overflow: hidden;
        }

        .card-header {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            background-color: #f8f9fa;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-body {
            padding: 20px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        .status-pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: #856404;
        }

        .status-confirmed {
            background-color: rgba(40, 167, 69, 0.2);
            color: #155724;
        }

        .status-completed {
            background-color: rgba(46, 78, 173, 0.2);
            color: var(--primary);
        }

        .status-canceled {
            background-color: rgba(220, 53, 69, 0.2);
            color: #721c24;
        }

        .status-payment-pending {
            background-color: rgba(108, 117, 125, 0.2);
            color: #495057;
        }

        .reservation-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .detail-item {
            margin-bottom: 15px;
        }

        .detail-label {
            font-size: 14px;
            color: var(--gray);
            margin-bottom: 5px;
        }

        .detail-value {
            font-weight: 500;
        }

        .vehicle-info {
            display: flex;
            align-items: center;
            border: 1px solid #eee;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }

        .vehicle-icon {
            font-size: 24px;
            margin-right: 15px;
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
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

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #bd2130;
        }

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .btn-disabled {
            background-color: var(--gray);
            color: white;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            justify-content: flex-end;
        }

        .reservation-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .history-item {
            display: flex;
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 8px;
        }

        .history-date {
            min-width: 100px;
            border-right: 1px solid #eee;
            padding-right: 15px;
            margin-right: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .history-date-day {
            font-size: 20px;
            font-weight: bold;
        }

        .history-date-month {
            font-size: 14px;
            color: var(--gray);
        }

        .history-details {
            flex: 1;
        }

        .history-locations {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .location-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: var(--primary);
            margin: 0 10px;
        }

        .history-price {
            font-weight: bold;
            text-align: right;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--gray);
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        .total-amount {
            background-color: var(--light-gray);
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-label {
            font-weight: 500;
            font-size: 16px;
        }

        .total-value {
            font-weight: 700;
            font-size: 18px;
            color: var(--primary);
        }

        .payment-info {
            margin-top: 15px;
            padding: 10px;
            border-radius: 5px;
            background-color: rgba(255, 193, 7, 0.1);
            border-left: 4px solid var(--warning);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            overflow: auto;
        }

        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border-radius: 10px;
            max-width: 500px;
            position: relative;
        }

        .close-modal {
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            cursor: pointer;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 5px;
            background-color: white;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            z-index: 1100;
            transform: translateX(150%);
            transition: transform 0.3s ease-out;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .notification.show {
            transform: translateX(0);
        }

        .notification-success {
            border-left: 4px solid var(--success);
        }

        .notification-error {
            border-left: 4px solid var(--danger);
        }

        .notification-warning {
            border-left: 4px solid var(--warning);
        }

        .loading {
            text-align: center;
            padding: 40px;
            color: var(--gray);
        }

        .loading-spinner {
            display: inline-block;
            width: 50px;
            height: 50px;
            border: 3px solid rgba(0, 0, 0, .1);
            border-radius: 50%;
            border-top-color: var(--primary);
            animation: spin 1s ease-in-out infinite;
            margin-bottom: 15px;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        @media (max-width: 768px) {
            .reservation-details {
                grid-template-columns: 1fr;
            }

            .history-item {
                flex-direction: column;
            }

            .history-date {
                border-right: none;
                border-bottom: 1px solid #eee;
                padding-right: 0;
                padding-bottom: 10px;
                margin-right: 0;
                margin-bottom: 10px;
                flex-direction: row;
                align-items: center;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div onclick="redirectToHome()" class="logo" style="cursor: pointer;">
        Mega<span>City</span>Cab
    </div>
    <div class="nav-links">
        <a href="home.jsp">Home</a>
        <a href="booking.jsp">Book a Ride</a>
        <a href="about.jsp">Contact</a>
    </div>
</nav>

<div class="container">
    <h1 class="page-title">My Reservations</h1>

    <div class="tab-container">
        <div class="tabs">
            <div class="tab active" onclick="switchTab(0)">Active Reservations</div>
            <div class="tab" onclick="switchTab(1)">Booking History</div>
        </div>
    </div>

    <!-- Active Reservations Tab Content -->
    <div class="tab-content active-reservations">
        <div class="loading" id="activeReservationsLoading">
            <div class="loading-spinner"></div>
            <p>Loading your reservations...</p>
        </div>
        <div id="activeReservationsContainer"></div>
    </div>

    <!-- Booking History Tab Content (hidden by default) -->
    <div class="tab-content booking-history" style="display: none;">
        <div class="loading" id="bookingHistoryLoading">
            <div class="loading-spinner"></div>
            <p>Loading your booking history...</p>
        </div>
        <div id="bookingHistoryContainer" class="reservation-list"></div>
    </div>
</div>

<!-- Cancellation Request Modal -->
<div id="cancelModal" class="modal">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <h3>Request Reservation Cancellation</h3>
        <p>Are you sure you want to request cancellation for this reservation? This request will be sent to our admin
            team for review.</p>
        <div class="modal-actions">
            <button class="btn btn-primary" id="cancelModalClose">No, Keep Reservation</button>
            <button class="btn btn-danger" id="confirmCancelRequest">Yes, Request Cancellation</button>
        </div>
    </div>
</div>

<!-- Notification -->
<div id="notification" class="notification">
    <div id="notificationMessage">Notification message</div>
</div>

<script>
    let currentReservationId = null;

    async function fetchAllReservations()   {
        try {
            const response = await fetch('reservation/customer/get', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                }
            });

            if (!response.ok) {
                throw new Error('Failed to fetch active reservations');
            }

            return await response.json();
        } catch (error) {
            console.error('Error fetching active reservations:', error);
            showNotification('Failed to load reservations. Please try again later.', 'error');
            return [];
        }
    }

    async function fetchActiveReservations() {
        let reservations = await fetchAllReservations();

        return reservations.filter(res => res.status==="Pending");
    }

    async function fetchBookingHistory() {
        return await fetchAllReservations();
    }

    async function requestCancellation(reservationId) {
        try {
            const response = await fetch('reservation/customer/cancel?reservationId=' + encodeURIComponent(reservationId), {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
            });

            if (!response.ok) {
                throw new Error('Failed to request cancellation');
            }

            return await response.text();
        } catch (error) {
            console.error('Error requesting cancellation:', error);
            showNotification('Failed to request cancellation. Please try again later.', 'error');
            return null;
        }
    }

    function renderActiveReservations(reservations) {
        const container = document.getElementById('activeReservationsContainer');

        if (reservations.length === 0) {
            container.innerHTML = '<div class="empty-state"><div class="empty-icon">📅</div><h3>No Active Reservations</h3><p>You don&apos;t have any active reservations at the moment.</p></div>';
            return;
        }

        let html = '';

        reservations.forEach(reservation => {
            const formattedDate = new Date(reservation.datetime).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            const formattedDateTime = new Date(reservation.datetime).toLocaleString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });

            const statusClass = getStatusClass(reservation.status);
            const vehicleIcon = getVehicleIcon(reservation.vehicleType);

            html += '' +
                '<div class="card reservation-card" data-id="' + reservation.id + '" data-status="' + reservation.status + '" data-payment="' + reservation.paymentStatus + '">' +
                '<div class="card-header">' +
                '<div>' +
                '<h3>Reservation #' + reservation.id + '</h3>' +
                '<span>' + formattedDate + '</span>' +
                '</div>' +
                '<span class="status-badge ' + statusClass + '">' + reservation.status + '</span>' +
                '</div>' +
                '<div class="card-body">' +
                '<div class="reservation-details">' +
                '<div class="detail-item">' +
                '<div class="detail-label">Pickup Location</div>' +
                '<div class="detail-value">' + reservation.pickupLocation + '</div>' +
                '</div>' +
                '<div class="detail-item">' +
                '<div class="detail-label">Dropoff Location</div>' +
                '<div class="detail-value">' + reservation.dropOffLocation + '</div>' +
                '</div>' +
                '<div class="detail-item">' +
                '<div class="detail-label">Date & Time</div>' +
                '<div class="detail-value">' + formattedDateTime + '</div>' +
                '</div>' +
                '<div class="detail-item">' +
                '<div class="detail-label">Passengers</div>' +
                '<div class="detail-value">' + reservation.passengerCount + '</div>' +
                '</div>' +
                '</div>' +
                '<div class="vehicle-info">' +
                '<div class="vehicle-icon">' + vehicleIcon + '</div>' +
                '<div>' +
                '<div class="vehicle-type">' + reservation.vehicleType + '</div>' +
                '<div class="vehicle-details">' + (reservation.vehicle || '') + '</div>' +
                '</div>' +
                '</div>' +
                '<div class="total-amount">' +
                '<div class="total-label">Total Amount:</div>' +
                '<div class="total-value">Rs. ' + reservation.payment.toLocaleString() + '</div>' +
                '</div>' +
                '<div class="payment-info">' +
                'Payment status: <strong>' + reservation.paymentStatus + '</strong>.' +
                '' + getPaymentMessage(reservation.status, reservation.paymentStatus) + '' +
                '</div>' +
                '<div class="action-buttons">' +
                '' + (reservation.status === 'Pending' || reservation.status === 'Confirmed'
                    ? '<button class="btn btn-danger request-cancel-btn" onclick="openCancelModal(\'' + reservation.id + '\')">Request Cancellation</button>'
                    : '') + '' +
                '</div>' +
                '</div>' +
                '</div>';

        });

        container.innerHTML = html;
    }

    function renderBookingHistory(bookings) {
        const container = document.getElementById('bookingHistoryContainer');

        if (bookings.length === 0) {
            container.innerHTML = '<div class="empty-state">' +
                '<div class="empty-icon">📜</div>' +
                '<h3>No Booking History</h3>' +
                '<p>You don&apos;t have any past bookings yet.</p>' +
                '</div>';
            return;
        }

        let html = '';

        bookings.forEach(booking => {
            const bookingDate = new Date(booking.datetime);
            const day = bookingDate.getDate().toString().padStart(2, '0');
            const month = bookingDate.toLocaleString('en-US', {month: 'short'});

            html += '<div class="history-item">' +
                '<div class="history-date">' +
                '<div class="history-date-day">' + day + '</div>' +
                '<div class="history-date-month">' + month + '</div>' +
                '</div>' +
                '<div class="history-details">' +
                '<div class="history-locations">' +
                '<span>' + booking.pickupLocation + '</span>' +
                '<span class="location-dot"></span>' +
                '<span>' + booking.dropOffLocation + '</span>' +
                '</div>' +
                '<div class="detail-label">Driver: ' + booking.driver + ' • Vehicle: ' + booking.vehicle + '</div>' +
                '</div>' +
                '<div class="history-price">' +
                'Rs. ' + booking.payment.toLocaleString() + '' +
                '</div>' +
                '</div>';

        });

        container.innerHTML = html;
    }

    function getStatusClass(status) {
        switch (status) {
            case 'Pending':
                return 'status-badge status-pending';
            case 'Confirmed':
                return 'status-badge status-confirmed';
            case 'Completed':
                return 'status-badge status-completed';
            case 'Canceled':
                return 'status-badge status-canceled';
            case 'Cancellation Requested':
                return 'status-badge status-warning';
            default:
                return 'status-badge';
        }
    }

    function getVehicleIcon(vehicleType) {
        switch (vehicleType) {
            case 'Economy':
                return '🚗';
            case 'Comfort':
                return '🚙';
            case 'Premium':
                return '🏎️';
            case 'SUV':
                return '🚐';
            default:
                return '🚕';
        }
    }

    function getPaymentMessage(status, paymentStatus) {
        if (paymentStatus === 'Not confirmed') {
            return 'Your reservation is pending admin confirmation.';
        } else if (paymentStatus === 'Confirmed') {
            return 'Your reservation is confirmed.';
        } else {
            return '';
        }
    }

    async function loadActiveReservations() {
        document.getElementById('activeReservationsLoading').style.display = 'block';
        document.getElementById('activeReservationsContainer').innerHTML = '';

        const reservations = await fetchActiveReservations();

        document.getElementById('activeReservationsLoading').style.display = 'none';
        renderActiveReservations(reservations);
    }

    async function loadBookingHistory() {
        document.getElementById('bookingHistoryLoading').style.display = 'block';
        document.getElementById('bookingHistoryContainer').innerHTML = '';

        const bookings = await fetchBookingHistory();

        document.getElementById('bookingHistoryLoading').style.display = 'none';
        renderBookingHistory(bookings);
    }

    function switchTab(tabIndex) {
        const tabs = document.querySelectorAll('.tab');
        const tabContents = document.querySelectorAll('.tab-content');

        // Remove active class from all tabs
        tabs.forEach(t => t.classList.remove('active'));

        // Add active class to clicked tab
        tabs[tabIndex].classList.add('active');

        // Hide all tab contents
        tabContents.forEach(content => {
            content.style.display = 'none';
        });

        // Show the selected tab content
        tabContents[tabIndex].style.display = 'block';

        // Load data for the selected tab
        if (tabIndex === 0) {
            loadActiveReservations();
        } else if (tabIndex === 1) {
            loadBookingHistory();
        }
    }

    function openCancelModal(reservationId) {
        currentReservationId = reservationId;
        document.getElementById('cancelModal').style.display = 'block';
    }

    function showNotification(message, type = 'success') {
        const notification = document.getElementById('notification');
        const notificationMessage = document.getElementById('notificationMessage');

        // Set message
        notificationMessage.textContent = message;

        // Set type
        notification.className = 'notification';
        notification.classList.add(`notification-${type}`);

        // Show notification
        notification.classList.add('show');

        // Hide after 5 seconds
        setTimeout(() => {
            notification.classList.remove('show');
        }, 5000);
    }

    async function confirmCancellation() {
        const result = await requestCancellation(currentReservationId);

        if (result) {
            document.getElementById('cancelModal').style.display = 'none';
            showNotification('Cancellation request sent successfully. An admin will review your request shortly.', 'success');

            // Reload active reservations to show updated status
            loadActiveReservations();
        }
    }

    function redirectToHome() {
        window.location.href = "home.jsp";
    }

    document.addEventListener('DOMContentLoaded', function () {
        // Check if there's a tab parameter in the URL
        const urlParams = new URLSearchParams(window.location.search);
        const tabParam = urlParams.get('tab');

        // Set up modal event listeners
        const cancelModalClose = document.getElementById('cancelModalClose');
        const closeModalBtn = document.querySelector('.close-modal');
        const confirmCancelBtn = document.getElementById('confirmCancelRequest');
        const cancelModal = document.getElementById('cancelModal');

        cancelModalClose.addEventListener('click', function () {
            cancelModal.style.display = 'none';
        });

        closeModalBtn.addEventListener('click', function () {
            cancelModal.style.display = 'none';
        });

        confirmCancelBtn.addEventListener('click', confirmCancellation);

        // Close modal when clicking outside
        window.addEventListener('click', function (event) {
            if (event.target === cancelModal) {
                cancelModal.style.display = 'none';
            }
        });

        // If the tab parameter is 'history', switch to the history tab
        if (tabParam === 'history') {
            switchTab(1);
        } else {
            // Load active reservations by default
            loadActiveReservations();
        }
    });
</script>
</body>
</html>