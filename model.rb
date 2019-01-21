class Recipe
  attr_accessor :name, :description, :prep_time, :done, :difficulty
  def initialize(name, description, prep_time, done = false, difficulty)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = done
    @difficulty = difficulty
  end

  def done?
    return @done
  end

  def to_a
    [@name, @description, @prep_time, @done, @difficulty]
  end
end
