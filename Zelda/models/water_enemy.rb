class Waterenemy
  def initialize(window, x, y)
    @swim_enemy = Gosu::Image.new(window, "img/swim_enemy.png", false)
    @x = x
    @y = y
    @window = window

  end

  def bounds
    BoundingBox.new(@x, @y, 0, 0)
  end

  def draw
    @swim_enemy.draw(@x, @y, 1)
  end



  def update
    # if @direction == :horizontal
    #   @x += @speed
    # else
    #   @y += @speed
    # end
  end


end
