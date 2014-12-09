class Enemy
  def initialize(window, x, y, direction, speed)
    @image = Gosu::Image.new(window, "img/enemy.png", false)
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

  # def flip
  #   draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
  # end

  def update
    if @direction == :horizontal
      @x += @speed
    else
      @y += @speed
    end
  end


end
