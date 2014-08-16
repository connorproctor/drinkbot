class DrinkMaker
  SECONDS_PER_UNIT = 1

  def initialize(drink, size)
    @recipe = drink.recipe_steps
    @size = size
  end

  def pour_duration

  end

  def make_drink
    groups = build_groups
    groups.each_value do |group|
      pour_group(group)
    end
    puts "test"
  end

private
  
  # each group is poured such that all ingredients finish at the same time
  def pour_group(group)
    max_amount = group.maximum :amount
    max_pour_duration = max_amount * unit_factor * SECONDS_PER_UNIT

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
    threads.each &:join
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
    group_keys = @recipe.pluck(:priority).uniq.sort
    group_keys.each do |group_key|
      groups[group_key] = @recipe.where(priority: group_key)
    end
    return groups
  end
end