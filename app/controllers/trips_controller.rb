class TripsController < ApplicationController

  def index
    
	end
	
  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
    end
	end
	
  def new
  end
  
  def create
    if !(params[:trip].nil?)
      @trip = Trip.new(trip_params)

      if @trip.save
        redirect_to passenger_path(@trip.passenger_id)
        return
      end
    else
      redirect_to root_path
    end
	end
	
  def edit
	end
	
  def update
	end
	
  def destroy
	end
	
  def complete
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
	end
	
end
