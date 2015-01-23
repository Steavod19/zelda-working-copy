class Menu
  attr_accessor :music

  def initialize(window, x, y, music)
    @window = window
    @y = y
    @x = x
    @music = music

  end

  def draw
    @title.draw(@x, @y, 0)
  end

end
