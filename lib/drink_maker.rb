class DrinkNotAvailable < ArgumentError; end

class DrinkMaker
  SECONDS_PER_UNIT = 15

  def self.available_drinks
    available_ingredients = []
    Pump.all.each do |pump|
      available_ingredients << pump.ingredient
    end

    drinks = []
    Drink.all.each do |drink|
      if (drink.ingredients - available_ingredients).empty?
        drinks << drink
      end
    end

    return drinks
  end

  def initialize(drink, size)
    throw DrinkNotAvailable unless DrinkMaker.available_drinks.include? drink
    @recipe = drink.recipe_steps
    @size = size
  end

  def pour_duration
    groups = build_groups
    duration = 0
    groups.each_value do |group|
      duration += group_pour_duration(group)
    end
    return duration
  end

  def make_drink
    groups = build_groups
    groups.each_value do |group|
      pour_group(group)
    end
  end

  private
  
  # each group is poured such that all ingredients finish at the same time
  def pour_group(group)
    max_pour_duration = group_pour_duration(group)

    threads = []
    group.each do |step|
      duration = step.amount * unit_factor * SECONDS_PER_UNIT
      delay = max_pour_duration - duration
      pump = step.ingredient.pumps.first
      threads << Thread.new do
        sleep delay
        pump_milliseconds(pump, duration)
      end
    end
    #threads.each &:join
  end
  
  def pump_milliseconds(pump, duration)
    Arduino.instance.turn_on_pump(pump)
    sleep duration
    Arduino.instance.turn_off_pump(pump)
  end

  # amount * unit_factor == amount in units
  def unit_factor
    total_amount = 0 
    @recipe.each do |step|
      total_amount += step.amount
    end
    return @size.to_f/total_amount
  end

  def build_groups
    groups = {}
    group_keys = @recipe.pluck(:group).uniq.sort
    group_keys.each do |group_key|
      groups[group_key] = @recipe.where(group: group_key)
    end
    return groups
  end

  def group_pour_duration(group)
    max_amount = group.maximum :amount
    return max_amount * unit_factor * SECONDS_PER_UNIT
  end
end