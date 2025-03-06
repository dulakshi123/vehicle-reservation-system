package com.dulakshi.vrs.entity;

public enum Status {
    /**
     * Status is maintained for four entities: Driver, Vehicle, Reservation, Payment
     * Driver: Available, On_Trip
     * Vehicle: Available, On_Trip, Under_Maintenance
     * Reservation: Booked, Checked_In
     * Payment: Pending, Paid
     */
    ACTIVE, INACTIVE, AVAILABLE, ON_TRIP, UNDER_MAINTENANCE,
    BOOKED, CHECKED_IN, PENDING, PAID;
}
