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
		@driver = Driver.new(driver_params)

		if @driver.save
			flash[:success] = 'Driver added'
			redirect_to driver_path(@driver.id)
			return
		else
			render :new
			return
		end
	end

	def edit
		@driver = Driver.find_by(id: params[:id])

		if @driver.nil?
			redirect_to drivers_path
			return
		end
	end

	def update
		@driver = Driver.find_by(id: params[:id])

		if @driver.nil?
			head :not_found
			return
		elsif @driver.update(driver_params)
			redirect_to driver_path(@driver.id)
      flash[:success] = 'Driver updated'
      return
    else
      render :edit
      return
    end
	end

	def destroy
		@driver = Driver.find_by(id: params[:id])

		if @driver.nil?
			redirect_to drivers_path
			return
		end

		@driver.destroy

		redirect_to drivers_path
		flash[:success] = 'Driver removed'
		return
	end

	def set_available
		@driver = Driver.find_by(id: params[:id])
		@driver.available?
		
		redirect_to driver_path(@driver.id)
	end

	private

	def driver_params
		return params.require(:driver).permit(:name, :vin, :available)
	end

end
