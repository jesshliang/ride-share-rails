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
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M', available: true)
      passenger = Passenger.create(name: "test person", phone_num: "1234567")

      expect {
        post passenger_trips_path(passenger.id)
      }.must_change 'Trip.count', 1

      new_trip = Trip.first
      
      expect(new_trip.rating).must_be_nil
      expect(new_trip.cost).must_be_kind_of Integer
      expect(new_trip.driver_id).must_equal driver.id
      expect(new_trip.passenger_id).must_equal passenger.id

      must_redirect_to passenger_path(passenger.id)
    end

    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M', available: true)
      passenger = Passenger.create(name: "test person", phone_num: "1234567")

      expect {
        post passenger_trips_path(-1)
      }.wont_change 'Trip.count'

      must_redirect_to passenger_path(-1)
    end
  end

  describe "edit" do
    before do
      @driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M', available: true)
      @passenger = Passenger.create(name: "test person", phone_num: "1234567")
    end

    it "responds with success when getting the edit page for an existing, valid trip" do
      trip = Trip.create(
        passenger_id: @passenger.id,
        driver_id: @driver.id,
        date: Date.today,
        rating: nil,
        cost: rand(1...3000)
      )

      get edit_trip_path(trip.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing trip" do
      get edit_trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M', available: true)
      @passenger = Passenger.create(name: "test person", phone_num: "1234567")
      @trip = Trip.create(
        passenger_id: @passenger.id,
        driver_id: @driver.id,
        date: Date.today,
        rating: nil,
        cost: rand(1...3000)
      )
    end

    let (:update_hash) {
      {
        trip: {
          rating: 2
        }
      }
    }

    it "can update an existing trip with valid information accurately, and redirect" do
      expect {
        patch trip_path(@trip.id), params: update_hash
      }.wont_change 'Trip.count'

      must_redirect_to trip_path(@trip.id)

      find_trip = Trip.find_by(id: @trip.id)
      expect(find_trip.rating).must_equal update_hash[:trip][:rating]
    end

    it "does not update any trip if given an invalid id, and responds with a 404" do
      expect {
        patch trip_path(-1), params: update_hash
      }.wont_change 'Trip.count'

      must_respond_with :not_found
    end

    it "does not update a Trip if the form data violates Driver validations, and responds with a redirect" do
      update_trip = {
        trip: {
          rating: 8
        }
      }

      expect {
        patch trip_path(@trip.id), params: update_trip
      }.wont_change 'Trip.count'

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "destroys the Trip instance in db when Trip exists, then redirects" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M', available: true)
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      trip = Trip.create(
        passenger_id: passenger.id,
        driver_id: driver.id,
        date: Date.today,
        rating: nil,
        cost: rand(1...3000)
      )

      expect {
        delete trip_path(trip.id)
      }.must_differ 'Trip.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "does not change the db when the Trip does not exist, then responds with redirect" do
      expect {
        delete trip_path(-1)
      }.wont_change 'Driver.count'

      must_respond_with :not_found
    end
  end
end
