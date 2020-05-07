class DriversController < ApplicationController

	def index
		@drivers = Driver.all
	end

	def show
		@driver = Driver.find_by(id: params[:id])

		if @driver.nil?
			head :not_found
			return
		end
	end

	def new
		@driver = Driver.new
	end

	def create

	end

	def edit

	end

	def update

	end

	def destroy

	end

	private

	def driver_params

	end
end
