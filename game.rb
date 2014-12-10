require 'rubygems' # only necessary in Ruby 1.8
require 'gosu'
require 'pry'

require_relative 'models/player'
require_relative 'models/enemy'
require_relative 'models/bounding_box'
require_relative 'models/menu'
require_relative 'models/background'


class GameWindow < Gosu::Window

  attr_reader :music

  def initialize
    super(1000, 520, false)
    self.caption = 'Link Zombie Battle HD2000'

    @background_image = Gosu::Image.new(self, "img/water_background.png", true)
    @player = Player.new(self)
    @player.warp(320, 240)
    @enemies = Array.new
    @enemy_counter = 0
    @menu = Menu.new(self, 0, 0, @music)
    @state = :menu
    @background = Background.new(self, 0, 0)
    @music = true

  end

  def update
    if @state == :menu
      @background.menu_music.play
    else
      @background.menu_music.pause
    end

    if @state == :running
      @background.game_music.play
    else
      @background.game_music.pause
    end

    if button_down? Gosu::KbSpace then
      @state = :running
    end
    # menu_action = @menu.update
    # if menu_action == "start"
    #   @state = :running
    # end
    # @menu.menu_action = nil
    #
    if @state == :running

      if button_down? Gosu::KbLeft then
        @player.go_left
      end
      if button_down? Gosu::KbRight then
        @player.go_right
      end
      if button_down? Gosu::KbUp then
        @player.go_up
      end
      if button_down? Gosu::KbDown then
        @player.go_down
      end
      @player.move
      @enemy_counter += 1
      summon_enemies
      @enemies.each {|enemy| enemy.update}
      player_killed?
    end

    # if @state == :lose
    #   @enemies.each {|e| e.state == :pause}
    # end

  end

  def draw
     if @state == :menu
       @menu.draw
     end

     if @state == :running

    if button_down? Gosu::KbLeft then
      if button_down?Gosu::KbA then
        @player.draw_strike_left
      else
        @player.draw_left
      end
    elsif button_down? Gosu::KbRight then
      if button_down?Gosu::KbA then
        @player.draw_strike_right
      else
        @player.draw_right
      end
    elsif button_down? Gosu::KbUp then
      if button_down?Gosu::KbA then
        @player.draw_strike_up
      else
        @player.draw_up
      end
    elsif button_down? Gosu::KbDown then
      if button_down?Gosu::KbA then
        @player.draw_strike_down
      else
        @player.draw
      end
    else
      @player.draw
    end



    @background_image.draw(0, 0, 0)
    @enemies.each {|enemy| enemy.draw}
     end

     if @state == :lose
      #  @menu.lose_screen.draw
     end

  end

  def summon_enemies
    x_entry_point = [86, 1050].sample
    y_entry_point = [-30, 540].sample
    if @enemy_counter % 60 == 0

      y_spawn_arr = Array.new
      # y_spawn = (255..405).to_a
      points_arr = [101..130, 192..220, 296..305, 392..400]
      points_arr.each do |x|
        y_spawn_arr << x.to_a
      end
      y_spawn = y_spawn_arr.flatten!



      x_spawn = (415..570).to_a

      if x_entry_point == 86 || y_entry_point == -30
        speed = (2..5).to_a
      elsif x_entry_point == 1050 || y_entry_point == 540
        speed = (-5..-2).to_a
      end


      number = (1..10).to_a

      if number.sample > 5
        @enemies << Enemy.new(self, x_entry_point, y_spawn.sample, :horizontal, speed.sample)
      else
        @enemies << Enemy.new(self, x_spawn.sample, y_entry_point, :vertical, speed.sample)
      end
    end
  end

  def player_killed?
    @enemies.each do |enemy|
      if enemy.bounds.intersects?(@player.bounds)
        @state = :lose
      end
    end
  end

  # def reset(state)
  #   @menu = Menu.new(self, 0, 0)
  #   @player = Player.new(self, 400, 50)
  #   # @state = state
  #   @game_end = nil
  # end



  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


window = GameWindow.new
window.show
