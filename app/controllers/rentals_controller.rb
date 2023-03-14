# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :authorize_user!, only: %i[confirm]
  before_action :set_rental, only: %i[show confirm review start]

  def index
    @rentals = Rental.where(subsidiary: current_subsidiary)
  end

  def show
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @categories = Category.all
  end

  def create
    @rental = Rental.new(**rental_params, subsidiary: current_subsidiary)
    result = RentalScheduler.new(@rental).call
    if result.success?
      redirect_to rental_path(@rental.id)
    else
      @clients = Client.all
      @categories = Category.all
      render :new
    end
  end

  def confirm
    if (@car = Car.find_by(id: params[:car_id]))
      @rental.rental_items.create(rentable: @car, daily_rate:
                                  @car.category.daily_rate)
      if (insurances = Insurance.where(id: params[:insurances_ids]))
        insurances.each do |ins|
          @rental.rental_items.create(rentable: ins, daily_rate: ins.daily_rate)
        end
      end
      if (addons = Addon.where(id: params[:addon_ids]))
        addon_items = addons.map(&:first_available_item)
        addon_items.each do |addon_item|
          @rental.rental_items.create(rentable: addon_item, daily_rate: addon_item.addon.daily_rate)
        end
      end
      @rental.update(price_projection: @rental.calculate_final_price)
      render :confirm
    else
      flash[:alert] = 'Carro deve ser selecionado'
      @cars = @rental.available_cars
      @addons = Addon.joins(:addon_items).where(addon_items: { status: :available }).group(:id)
      @insurances = @rental.category.insurances
      render :review
    end
  end

  def search
    @rental = Rental.find_by(reservation_code: params[:q])
    return redirect_to review_rental_path(@rental) if @rental

    flash[:alert] = 'Não foi possível encontrar a locação'
    redirect_to rentals_path
  end

  def review
    @rental.in_review!
    @cars = @rental.available_cars
    @addons = Addon.joins(:addon_items).where(addon_items: { status: :available }).group(:id)
    @insurances = @rental.category.insurances
  end

  def start
    @rental.ongoing!
    redirect_to @rental
  end

  private

  def set_rental
    @rental = RentalPresenter.new(Rental.find(params[:id]), current_user)
  end

  def rental_params
    params.require(:rental).permit(:category_id, :client_id, :start_date,
                                   :end_date,
                                   rental_items_attributes: [:car_id])
  end

  def authorize_user!
    @rental = Rental.find(params[:id])
    redirect_to @rental unless authorized?
  end

  def authorized?
    RentalPolicy.new(current_user, @rental).allowed?
  end
end
