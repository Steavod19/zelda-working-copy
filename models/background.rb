class Background

  attr_reader :game_music, :menu_music

  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x
    @game_music = Gosu::Song.new(window, 'music/overworld.mp3')
    @menu_music = Gosu::Song.new(window, 'music/intro.mp3')

  end

  def play
    # play(volume = 1, speed = 1, looping = false)
  end
end
