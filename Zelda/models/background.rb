class Background

  attr_reader :game_music, :menu_music, :sfx_sword_swing

  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x
    @game_music = Gosu::Song.new(window, 'music/overworld.mp3')
    @menu_music = Gosu::Song.new(window, 'music/intro.mp3')
    @sfx_sword_swing = Gosu::Sample.new(window, 'music/LOZ_sword.wav')
    @sfx_die = Gosu::Sample.new(window, 'music/die.wav')



  end

  # def bounds_blocks
  #
  #   @left = left
  #   @bottom = bottom
  #   @width = width
  #   @height = height
  #   @right = @left + @width
  #   @top = @bottom + @height
  #
  #   [l, b, w, h]
  #
  #   [0, 520, 94, 520]


  # end

end
