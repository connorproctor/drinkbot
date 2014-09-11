class DrinkbotController < ApplicationController
  
  def index
    @available_drinks = DrinkMaker.available_drinks
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

end
