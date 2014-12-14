class Player
  attr_reader :x, :y
  def initialize(window, x, y)
    @image = Gosu::Image.new(window, "img/zelda_sprites/link.png", false)
    @image_left = Gosu::Image.new(window, "img/zelda_sprites/link_left.png", false)
    @image_right = Gosu::Image.new(window, "img/zelda_sprites/link_right.png", false)
    @image_up = Gosu::Image.new(window, "img/zelda_sprites/link_up.png", false)
    @image_strike_right = Gosu::Image.new(window, "img/zelda_sprites/link_strike_right.png", false)
    @image_strike_left = Gosu::Image.new(window, "img/zelda_sprites/link_strike_left.png", false)
    @image_strike_up = Gosu::Image.new(window, "img/zelda_sprites/link_up_strike.png", false)
    @image_strike_down = Gosu::Image.new(window, "img/zelda_sprites/link_down_strike.png", false)
    @x = x
    @y = y
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end


  def stop
    @x = x
    @y = y
  end

  def go_left
    @x -= 2
  end

  def go_right
    @x += 2
  end

  def go_up
    @y -= 2
  end

  def go_down
    @y += 2
  end

  def move
    @x += 0
    @y += 0
    @x %= 1000
    @y %= 520
  end

  def bounds
    BoundingBox.new(@x, @y, 38, 41)
  end

  def sword_bounds_nil
    BoundingBox.new(@x, @y, 0, 0)
  end

  def sword_bounds_right
    BoundingBox.new(@x + 45, @y + 12, 31, 13)
  end

  def sword_bounds_left
    BoundingBox.new(@x - 45, @y + 12, 31, 13)
  end

  def sword_bounds_up
    BoundingBox.new(@x + 10, @y - 26, 15, 29)
  end

  def sword_bounds_down
    BoundingBox.new(@x + 10, @y + 37, 15, 27)
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

  def draw_strike_left
    @image_strike_left.draw(@x - 40, @y, 1)
  end

  def draw_strike_right
    @image_strike_right.draw(@x, @y, 1)
  end

  def draw_strike_up
    @image_strike_up.draw(@x, @y - 35, 1)
  end

  def draw_strike_down
    @image_strike_down.draw(@x, @y, 1)
  end

end
