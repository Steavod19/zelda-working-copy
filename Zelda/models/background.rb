class Background

  attr_reader :sfx_player_life, :game_over_music, :game_music, :menu_music, :sfx_sword_swing, :sfx_enemy_die, :sfx_player_health, :sfx_player_hit, :water

  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x
    @game_music = Gosu::Song.new(window, 'music/overworld.mp3')
    @menu_music = Gosu::Song.new(window, 'music/intro.mp3')
    @game_over_music = Gosu::Song.new(window, 'music/game_over.mp3')
    @sfx_sword_swing = Gosu::Sample.new(window, 'music/LOZ_sword.wav')
    @sfx_player_die = Gosu::Sample.new(window, 'music/die.wav')
    @sfx_enemy_die = Gosu::Sample.new(window, 'music/loz_kill.wav')
    @sfx_player_health = Gosu::Sample.new(window, 'music/LOZ_LowHealth.wav')
    @sfx_player_hit = Gosu::Sample.new(window, 'music/LOZ_Hurt.wav')
    @sfx_player_life = Gosu::Sample.new(window, 'music/LOZ_Get_Heart.wav')

  end

  def water
    BoundingBox.new(0, 520, 94, 520)
  end
  def tp_right
    BoundingBox.new(94, 98, 317, 98)
  end
  def tp_left
    BoundingBox.new(600, 98, 400, 98)
  end
  def bt_left
    BoundingBox.new(94, 520, 317, 80)
  end
  def bt_right
    BoundingBox.new(600, 520, 400, 80)
  end




end
