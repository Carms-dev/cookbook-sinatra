class Recipe
  attr_reader :name, :description, :prep_time, :difficulty, :done

  def initialize(args = {})
    @name = args[:name]
    @description = args[:description]
    @prep_time = args[:prep_time]
    @difficulty = args[:difficulty]
    @done = args[:done] == true
  end

  def done!
    @done = true
  end

  def undone!
    @done = false
  end
end
