require 'DrinkMaker'

class DrinkbotController < ApplicationController
  
  def make_drink
    drink = Drink.find(params[:drink])
    size = params[:size].to_i
    maker = DrinkMaker.new(drink, size)

    render text: maker.pour_duration, status: :success

    maker.make_drink
  end

  def update_pumps

  end

end
