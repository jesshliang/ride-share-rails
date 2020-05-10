require "test_helper"

describe TripsController do
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      trip = Trip.create(date: DateTime.now, rating: 2, cost: 100, driver_id: driver.id, passenger_id: passenger.id)

      get trip_path(trip.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      get trip_path(-1)

      must_redirect_to trips_path
    end
  end

  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')
      passenger = Passenger.create(name: "test person", phone_num: "1234567")

      data_hash = {
        trip: {
          date: DateTime.now,
          rating: 2,
          cost: 100,
          driver_id: driver.id,
          passenger_id: passenger.id,
        }
      }

      expect {
        post trips_path, params: data_hash
      }.must_change 'Trip.count', 1

      new_trip = Trip.first
      expect(new_trip.rating).must_equal data_hash[:trip][:rating]
      expect(new_trip.cost).must_equal data_hash[:trip][:cost]
      expect(new_trip.driver_id).must_equal data_hash[:trip][:driver_id]
      expect(new_trip.passenger_id).must_equal data_hash[:trip][:passenger_id]

      must_redirect_to trip_path(new_trip.id)
    end

    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      data_hash = {
        trip: {
          date: '',
          rating: '',
          cost: '',
          driver_id: '',
          passenger_id: ''
        }
      }

      expect {
        post trips_path, params: data_hash
      }.wont_change 'Trip.count'

      must_respond_with :ok
    end
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
