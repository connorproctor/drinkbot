class DrinkbotController < ApplicationController
  
  def index
    @available_drinks = DrinkMaker.available_drinks.shuffle
  end

  def settings
    @drinks = Drink.all
    @pumps = Pump.all
    @ingredients = Ingredient.all
  end

  def make_drink
    drink = Drink.find(params[:drink])
    size = params[:size].to_i
    maker = DrinkMaker.new(drink, size)

    maker.make_drink

    render text: maker.pour_duration, status: 200

  rescue DrinkNotAvailable => e
    render nothing: true, status: 500
  end

  def update_pumps
    pump_ingredient = params[:pump_ingredient]
    pump_ingredient.each do |p, i|
      Pump.update(p, ingredient_id: i)
    end
    redirect_to :settings, notice: "Pumps successfully saved!"
  end

  def turn_on_pump
    Pump.find(params[:pump_id]).turn_on

    render nothing: true, status: 200
  end

  def turn_off_pump
    Pump.find(params[:pump_id]).turn_off

    render nothing: true, status: 200
  end

  def turn_on_all_pumps
    Pump.turn_on_all

    render nothing: true, status: 200
  end

  def turn_off_all_pumps
    Pump.turn_off_all

    render nothing: true, status: 200
  end

end
