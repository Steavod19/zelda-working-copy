class Menu
  attr_accessor :selection, :music

  def initialize(window, x, y, music)
    @window = window
    @y = y
    @x = x
    @music = music

    @title = Gosu::Image.new(window, 'img/title_screen.png')
    @menu_action = nil



  end

  def draw
    @title.draw(@x, @y, 0)
    @window.music == true ? @music_value = "ON" : @music_value = "OFF"

  end

  def update
    @menu_action
  end
end
