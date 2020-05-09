class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      #redirect_to root_path
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    params = passenger_params

    @passenger = Passenger.new(passenger_params)
    if !params.nil?
      if @passenger.save
        redirect_to passenger_path(@passenger.id)
        return
      else
        render :new, :bad_request
        return
      end
      redirect_to passengers_path
      return
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end

    if @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :edit, :bad_request
      return
    end
  end
  
  def destroy
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
      return
    end

    @passenger.destroy

    redirect_to passengers_path
    return 
  end
 
  def request_trip
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
      return
    end

    driver = Driver.all.first
    date = DateTime.now

    trip_params = {
      trip: {
        date: date,
        driver_id: driver.id,
        passenger_id: passenger_id,
        rating: nil,
        cost: nil,
      }
    }

    redirect_to trips_path, params: trip_params
    return
  end

  # def complete
  #   @passenger = Passenger.find_by(id: params[:id])

  #   if @passenger.nil?
  #     redirect_to passengers_path
  #     return
  #   end

  #   if @passenger.completion_date == nil
  #     @passenger.completion_date = Time.now
  #   else
  #     @passenger.completion_date = nil
  #   end

  #   unless @passenger.save 
  #     redirect_to passengers_path
  #   end

  #   redirect_to passengers_path
  #   return 
  # end

  private 
  def passenger_params
    if !params[:passenger].nil?
      return params.require(:passenger).permit(:name, :phone_num)
    else
      return nil
    end
  end
end
