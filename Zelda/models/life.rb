class Life
  def initialize(window, x, y)
    @image = Gosu::Image.new(window, "img/health.png", false)
    @x = x
    @y = y
    @window = window

  end



  def draw
    @image.draw(@x, @y, 1)
  end


end
