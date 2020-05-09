require "test_helper"

describe TripsController do
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Ensure that there is a trip saved
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      trip = Trip.create(date: DateTime.now, rating: 2, cost: 100, driver_id: driver.id, passenger_id: passenger.id)

      # Act
      get trip_path(trip.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      # Act
      get trip_path(-1)
      
      # Assert
      must_respond_with :not_found
    end
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
