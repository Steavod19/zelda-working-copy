class Enemy
  def initialize(window, x, y, direction, speed)
    @image = Gosu::Image.new(window, "img/enemy.png", false)
    # @image_right = Gosu::Image.new(window, "img/enemy_right.png", false)
    # @swim_enemy = Gosu::Image.new(window, "img/swim_enemy.png", false)
    @x = x
    @y = y
    @direction = direction
    @speed = speed
    @window = window

  end

  def bounds
    BoundingBox.new(@x, @y, 30, 30)
  end

  def draw
    @image.draw(@x, @y, 1)
  end

  # def draw_swim
  #   @swim_enemy.draw(@x, @y, 1)
  # end

  def update
    if @direction == :horizontal
      @x += @speed
    else
      @y += @speed
    end
  end


end
