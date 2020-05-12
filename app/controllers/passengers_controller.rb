class PassengersController < ApplicationController
  def index
    #@passengers = Passenger.order(:id).all
    @passengers = Passenger.order(:id).all.page(params[:page])
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      flash[:success] = 'Passenger added'
      redirect_to passenger_path(@passenger.id)
    else
      render :new
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
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
      flash[:success] = 'Passenger updated'
      return
    else
      render :edit
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
    flash[:success] = 'Passenger removed'
    return 
  end
  
  private 
  def passenger_params
    if !params[:passenger].nil?
      return params.require(:passenger).permit(:name, :phone_num)
    else
      return nil
    end
  end
end
