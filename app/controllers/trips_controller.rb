class TripsController < ApplicationController
  # def index
  #   if params[:passenger_id].nil?
  #     @trips = Trip.all
  #   else
  #     @trips = @passenger.trips
  #     @passenger = Passenger.find_by(id: params[:passenger_id]).trips
  #   end
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
    driver = Driver.find_by(available: true)
    
    @trip = Trip.new(
      passenger_id: params[:passenger_id],
      driver_id: driver.id,
      date: Date.today,
      rating: 0,
      cost: rand(1...3000)
    )
    puts params
    if @trip.save
      driver.available?
      flash[:success] = 'Trip added'
      redirect_to passenger_path(params[:passenger_id])
      return
    else
      redirect_to passenger_path(params[:passenger_id])
      return
    end
  end
	
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
    elsif @trip.update()
      redirect_to trips_path
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
      flash[:success] = 'Trip removed'
      redirect_to root_path
      
      return
    end
  end
  
  def set_completion
		@trip = Trip.find_by(id: params[:id])
		@trip.update(completion: @trip.completed?)
		
		redirect_to trip_path(@trip.id)
	end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
	end
	
end
