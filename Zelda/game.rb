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
    # @water_enemies = Array.new
    # @water_enemies_counter = 0
    @menu = Menu.new(self, 0, 0, @music)
    @state = :menu
    @background = Background.new(self, 0, 0)
    @music = true
    @score_font = Gosu::Font.new(self, "Avenir", 450 / 15)
    @player_score = 0
    @player_health = 5



    # @collision = nil
    # @new_pos = @player.move





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

    # if @player_score == 5
    #   @enemy_counter += 1
    # elsif @player_score == 10
    #   @enemy_counter += 1
    # end


    if @state == :running
      if button_down? Gosu::KbLeft then
        @player.go_left
        if button_down?Gosu::KbA then
          enemy_killed?
        end
      end
      if button_down? Gosu::KbRight then
        @player.go_right
        if button_down?Gosu::KbA then
          enemy_killed?
        end
      end
      if button_down? Gosu::KbUp then
        @player.go_up
        if button_down?Gosu::KbA then
          enemy_killed?
        end
      end
      if button_down? Gosu::KbDown then
        @player.go_down
        if button_down?Gosu::KbA then
          enemy_killed?
        end
      end

      # @player.move
      # borders?
      # if @collision == true
      #   player.draw = @new_pos
      # else
        @player.move
      # end


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
            @player.sword_bounds_left
            if @result
              @background.sfx_enemy_die.play
            else
              @background.sfx_sword_swing.play
            end
          else
            @player.draw_left
          end
        elsif button_down? Gosu::KbRight then
          if button_down?Gosu::KbA then
            @player.draw_strike_right
            @player.sword_bounds_right
            if @result
              @background.sfx_enemy_die.play
            else
              @background.sfx_sword_swing.play
            end
          else
            @player.draw_right
          end
        elsif button_down? Gosu::KbUp then
          if button_down?Gosu::KbA then
            @player.draw_strike_up
            if @result
              @background.sfx_enemy_die.play
            else
              @background.sfx_sword_swing.play
            end
          else
            @player.draw_up
          end
        elsif button_down? Gosu::KbDown then
          if button_down?Gosu::KbA then
            @player.draw_strike_down
            if @result
              @background.sfx_enemy_die.play
            else
              @background.sfx_sword_swing.play
            end
          else
            @player.draw
          end
        else
          @player.draw
        end


      @background_image.draw(0, 0, 0)
      @score_font.draw("#{@player_score}", 923, 20, 1.0, 1.0, 1.0, Gosu::Color::BLACK)

      @enemies.each do |enemy|
        enemy.draw
      end

     end
    #  if @state == :low_health
    #    @background.sfx_player_health.play(1, -60, true)
    #  elsif @state == :lose
      #  @background.sfx_player_health.pause
      #  @menu.draw
    #  end

  end

  # def summon_water_enemies
  #
  # end

  def summon_enemies
    x_entry_point = [86, 1050].sample
    y_entry_point = [-30, 540].sample

    if @enemy_counter % 60 == 0
      y_spawn_arr = Array.new
      points_arr = [101..130, 192..220, 296..305, 392..400]

      points_arr.each do |x|
        y_spawn_arr << x.to_a
      end

      y_spawn = y_spawn_arr.flatten!

      x_spawn = (415..570).to_a

      if x_entry_point == 86 || y_entry_point == -30
        speed = (2..3).to_a
      elsif x_entry_point == 1050 || y_entry_point == 540
        speed = (-3..-2).to_a
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
        # @player_health -= 1
        #   if @player_health == 1
        #     @state = :low_health
        #   elsif @player_health == 0
            @state = :lose
          # end
      end
    end
  end


  def enemy_killed?
    @result = false
    dead_enemy = nil
    @enemies.each do |enemy|
      if enemy.bounds.intersects?(@player.sword_bounds_right) || enemy.bounds.intersects?(@player.sword_bounds_left) || enemy.bounds.intersects?(@player.sword_bounds_up) || enemy.bounds.intersects?(@player.sword_bounds_down)
        dead_enemy = enemy
        @result = true
        @player_score += 1
        break
      end
    end
    @enemies.delete(dead_enemy)
  end

  # def borders?
  #     if @player.bounds.intersects?(@background.water)
  #       @collision = true
  #     end
  # end





  # def reset(state)
  #   @menu = Menu.new(self, 0, 0)
  #   @player = Player.new(self, 0, 0)
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
