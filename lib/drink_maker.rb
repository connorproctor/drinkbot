class DrinkNotAvailable < ArgumentError; end

class DrinkMaker
  SECONDS_PER_OUNCE = 15

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
      sleep group_pour_duration(group)
    end
  end

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

private
  
  def pour_group(group)
    threads = []
    Thread.abort_on_exception = true
    group.each do |step|
      # delay = group_pour_duration(group) - step_pour_duration(step)
      step.pumps.each do |pump|
        threads << Thread.new do
          # sleep delay
          pump_milliseconds(pump, step_pour_duration(step))
          ActiveRecord::Base.connection.close
        end
      end
    end
    #threads.each &:join
  end
  
  def pump_milliseconds(pump, duration)
    pump.turn_on
    sleep duration
    pump.turn_off
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
    max = 0
    group.each do |step|
      max = step_pour_duration(step) if step_pour_duration(step) > max
    end
    return max
  end

  def step_pour_duration(step)
    pour_duration_sumation = step.amount * unit_factor * SECONDS_PER_OUNCE
    pour_duration_per_pump = pour_duration_sumation.to_f/step.pumps.count
    return pour_duration_per_pump
  end
end