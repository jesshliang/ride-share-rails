class TripsController < ApplicationController

  def index
    
	end
	
  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
	end
	
  def new
	end
	
  def create
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
    return params.require(:trip).permit(:name, :phone_num)
	end
	
end
