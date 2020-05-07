class TripsController < ApplicationController

	def index
	end
	
  def show
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

  private passenger_params

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
	end
	
end
