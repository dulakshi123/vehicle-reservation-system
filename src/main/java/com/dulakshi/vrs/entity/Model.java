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

    public static Model getModel(String vehicleType) {
        try {
            return Model.valueOf(vehicleType.toUpperCase());
        } catch (IllegalArgumentException | NullPointerException e) {
            throw new IllegalArgumentException("Invalid vehicle type: " + vehicleType);
        }
    }
}
