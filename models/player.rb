class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "img/link.png", false)
    @x = @y = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def go_left
    @x -= 4
  end

  def go_right
    @x += 4
  end

  def go_up
    @y -= 4
  end

  def go_down
    @y += 4
  end

  def move
    @x += 0
    @y += 0
    @x %= 1000
    @y %= 520
  end

  def bounds
    BoundingBox.new(@x, @y, 40, 50)
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end
