class TripsController < ApplicationController

  # def index
    
	# end
	
  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path, notice: 'Trip not found'
      return
    end
	end
	
  def new
    @trip = Trip.new
  end
  
  def create
    # passenger_trips = Trip.where(passenger_id: params[:passenger_id])
    
    # passenger_trips.each do |trip|
    #   if trip.rating == nil
    #     flash[:notice] = "Please complete and rate your previous trip"
    #     redirect_to passenger_path(params[:passenger_id])
    #     return
    #   end
    # end
    
    # driver = Driver.get_driver
    
    # if driver == nil
    #   flash[:notice] = "There are no available drivers"
    #   redirect_to passenger_path(params[:passenger_id])
    #   return
    # end
    
    # date = DateTime.now
    # cost = rand(1000..9999).to_i
    
    # trip_hash = {
    #   date: date,
    #   driver_id: driver.id,
    #   passenger_id: params[:passenger_id],
    #   rating: nil,
    #   cost: cost,
    # }
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:success] = 'Trip added'
      redirect_to trip_path(@trip.id)
    else
      render :new
    end
  end

    # if !(params[:trip].nil?)
    #   @trip = Trip.new(trip_params)

    #   if @trip.save
    #     redirect_to passenger_path(@trip.passenger_id)
    #     return
    #   end
    # else
    #   redirect_to root_path
    # end
	
  def edit
    id = params[:id]
    @trip = Trip.find_by(id: id)

    if @trip.nil?
      head :not_found
      return
    end
	end
	
  def update
    id = params[:id]
    @trip = Trip.find_by(id: id)

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trips_path(@trip.id)
      flash[:success] = 'Trip updated'
      return
    else
      render :edit
      return
    end
	end
	
  def destroy
    id = params[:id]
    @trip = Trip.find_by(id: id)

    
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to drivers_path
      flash[:success] = 'Trip removed'
      return
    end
  end
  
  def rate
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  # def complete
  # end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
	end
	
end
