require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      test_passenger = Passenger.create(name: "test person", phone_num: "1234567")
      get passengers_path
      must_respond_with :success
    end
    it "responds with success when there are no passengers saved" do
      expect(Passenger.count).must_equal 0
      get passengers_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      test_passenger = Passenger.create(name: "test person", phone_num: "1234567")
      get passenger_path(test_passenger.id)
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid passenger id" do
      get passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger_hash = {
        passenger: {
          name: "test passenger",
          phone_num: "1234567"
        }
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
    
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      passenger_hash = {
        name: '',
        phone_num: ''
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.wont_change 'Passenger.count'
      
      must_redirect_to passengers_path
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      test_passenger = Passenger.create(name: "test person", phone_num: "1234567")
      get edit_passenger_path(test_passenger.id)
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-1)
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    # Your tests go here
    # later my head hurts
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      test_passenger = Passenger.create(name: "test person", phone_num: "1234567")
      new_passenger = Passenger.find_by(id: test_passenger.id)
      
      expect {delete passenger_path(new_passenger.id) }.must_differ 'Passenger.count', -1
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
    
    it "does not change the db when the passenger does not exist, then responds with " do
      expect {delete passenger_path(-1)}.wont_change 'Passenger.count'
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "request trip" do
    it "creates a new trip" do
      test_passenger = Passenger.create(name: "test person", phone_num: "1234567")
      test_driver = Driver.create(name: "name", vin: "1234")
      expect {
        get request_trip_path(test_passenger.id)
      }.must_change 'test_passenger.trips.count', 1
    end
  end
end
