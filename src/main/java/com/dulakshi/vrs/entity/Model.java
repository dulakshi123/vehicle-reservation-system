package com.dulakshi.vrs.entity;

public enum Model {
    ECONOMY(4),
    COMFORT(4),
    VAN(8);

    private final int passengerCount;

    Model(int passengerCount) {
        this.passengerCount = passengerCount;
    }

    public int getPassengerCount() {
        return this.passengerCount;
    }
}
