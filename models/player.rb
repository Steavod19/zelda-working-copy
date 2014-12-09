class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "img/link.png", false)
    @image_left = Gosu::Image.new(window, "img/link_left.png", false)
    @image_right = Gosu::Image.new(window, "img/link_right.png", false)
    @image_up = Gosu::Image.new(window, "img/link_up.png", false)
    @x = @y = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def go_left
    @x -= 3
    # @player.draw_left
  end

  def go_right
    @x += 3
  end

  def go_up
    @y -= 3
  end

  def go_down
    @y += 3
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

  def draw_left
    @image_left.draw(@x, @y, 1)
  end

  def draw_right
    @image_right.draw(@x, @y, 1)
  end

  def draw_up
    @image_up.draw(@x, @y, 1)
  end


end
