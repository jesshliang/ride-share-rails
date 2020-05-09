require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')
      get drivers_path
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      expect(Driver.count).must_equal 0
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')
      get driver_path(driver.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      get driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      driver_hash = {
        driver: {
          name: 'Leroy Jenkins', 
          vin: 'SU9PYDRK6214WL15M'
        }
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_hash = {
        driver: {
          name: '',
          vin: ''
        }
      }

      expect {
        post drivers_path, params: driver_hash
      }.wont_change 'Driver.count'

      must_redirect_to drivers_path
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')

      get edit_driver_path(driver.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-1)

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    let (:update_hash) {
      {
        driver: {
          name: 'Not Leroy Jenkins',
          vin: 'SU9PYDRK6244WL15M'
        }
      }
    }

    it "can update an existing driver with valid information accurately, and redirect" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')
      driver_id = driver.id

      expect {
        patch driver_path(driver_id), params: update_hash
      }.wont_change 'Driver.count'

      must_respond_with :redirect

      find_driver = Driver.find_by(id: driver_id)
      expect(find_driver.name).must_equal update_hash[:driver][:name]
      expect(find_driver.vin).must_equal update_hash[:driver][:vin]
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      expect {
        patch driver_path(-1), params: update_hash
      }.wont_change 'Driver.count'

      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      skip
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      driver = Driver.create(name: 'Leroy Jenkins', vin: 'SU9PYDRK6214WL15M')

      expect {
        delete driver_path(driver.id)
      }.must_differ 'Driver.count', -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      expect {
        delete driver_path(-1)
      }.wont_change 'Driver.count'

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
end
