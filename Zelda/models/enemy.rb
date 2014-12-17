class Enemy
  attr_reader :x, :y
  def initialize(window, x, y, direction)
    # @image = Gosu::Image.new(window, "img/enemy.png", false)
    # @image_right = Gosu::Image.new(window, "img/enemy_right.png", false)
    # @swim_enemy = Gosu::Image.new(window, "img/swim_enemy.png", false)
    @x = x
    @y = y
    @direction = direction
    @window = window
    calc_speed
    @enemy_right_image = Gosu::Image.new(window, "img/enemy_right.png", false) 
    @enemy_down_image = Gosu::Image.new(window, "img/enemy_down.png", false) 
    @enemy_left_image = Gosu::Image.new(window, "img/enemy.png", false)
    @enemy_up_image =  Gosu::Image.new(window, "img/enemy_up.png", false) 
  end

  def bounds
    BoundingBox.new(@x, @y, 30, 30)
  end

  def draw
    case @direction
    when :horizontal_left
      @enemy_right_image.draw(@x, @y, 1)
    when :horizontal_right
      @enemy_left_image.draw(@x, @y, 1)
    when :vertical_bottom
      @enemy_up_image.draw(@x, @y, 1)
    when :vertical_top
      @enemy_down_image.draw(@x, @y, 1)
    end
  end

  def update
    if @direction == :horizontal_left || @direction == :horizontal_right
      @x += @speed
    else
      @y += @speed
    end
  end

  def calc_speed
    case @direction
    when :horizontal_left
      @speed = (2..3).to_a.sample
    when :horizontal_right
      @speed = (-3..-2).to_a.sample
    when :vertical_bottom
      @speed = (-3..-2).to_a.sample
    when :vertical_top
      @speed = (2..3).to_a.sample
    end
  end
end
