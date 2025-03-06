package com.dulakshi.vrs.entity;

public enum Model {
    SEDAN(4),
    HATCHBACK(3),
    SUV(4),
    MINIVAN(5),
    VAN(8),
    PREMIER(4);

    private final int passengerCount;

    Model(int passengerCount) {
        this.passengerCount = passengerCount;
    }

    public int getPassengerCount() {
        return this.passengerCount;
    }
}
