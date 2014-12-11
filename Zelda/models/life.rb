class Life
  def initialize(window, x, y)
    @image = Gosu::Image.new(window, "img/health.png")
    @x = x
    @y = y
    @window = window
  end

  def draw
    @image.draw(@x, @y, 3)
  end

end
