require 'rubygems'
require 'gosu'
require 'pry'

require_relative 'models/player'
require_relative 'models/enemy'
require_relative 'models/bounding_box'
require_relative 'models/menu'
require_relative 'models/background'
require_relative 'models/life'


class GameWindow < Gosu::Window

  attr_reader :music

  def initialize
    super(1000, 520, false)
    self.caption = 'Link Zombie Battle HD2000'

    @background_image = Gosu::Image.new(self, "img/water_background.png", true)
    @player = Player.new(self, 600, 350)
    @player.warp(500, 240)
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

    @life = Array.new
    @player_health = 4
    player_life
    # binding.pry

    # @collision = nil
    # @new_pos = @player.move

    @bounds_arr = [BoundingBox.new(0, 520, 94, 520),
    BoundingBox.new(94, 98, 317, 98),
    BoundingBox.new(600, 98, 400, 98),
    BoundingBox.new(94, 520, 317, 80),
    BoundingBox.new(600, 520, 400, 80)]

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

    if button_down? Gosu::KbSpace
      @state = :running
    end

    if @state == :running

    if @collision != true

          if button_down? Gosu::KbLeft
    #        if @player.x > 94 && @player.y > 92
              @player.go_left
              if button_down?Gosu::KbA
                enemy_killed?
              end
          end

          if button_down? Gosu::KbRight
    #        if @player.x < 960 && @player.y > 92
              @player.go_right
    #        end
            if button_down?Gosu::KbA
              enemy_killed?
            end
          end
          if button_down? Gosu::KbUp
    #        if @player.y > 98
              @player.go_up
    #        end
            if button_down?Gosu::KbA
              enemy_killed?
            end
          end
          if button_down? Gosu::KbDown
    #        if @player.y < 398
              @player.go_down
    #        end
            if button_down?Gosu::KbA
              enemy_killed?
            end
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
      borders?
    end

    if @state == :lose
      reset
      @state = :menu
    end

  end

  def draw


    if @state == :menu
      @menu.draw
    end



    if @state == :running

      @life.each do |heart|
        heart.draw
      end

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

      if @hit == true
        @background.sfx_player_hit.play
        @life.pop
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


  def player_life
    x1 = 733
    y1 = 26
    @player_health.times do
      @life << Life.new(self, x1, y1)
      x1 += 30
    end
  end


  def player_killed?
    @hit = nil
    enemy_hit = nil
    @enemies.each do |enemy|
      if enemy.bounds.intersects?(@player.bounds)
        enemy_hit = enemy
        @hit = true
        @player_health -= 1
        if @player_health == 0
          @state = :lose
        end
      end
    end
    @enemies.delete(enemy_hit)
  end


  def enemy_killed?
    @result = nil
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




  def borders?
    @collion = nil
    @bounds_arr.each do |nono_square|
      if @player.bounds.intersects?(nono_square)
       @collision = true
      end
    end
  end

  def reset
    @menu = Menu.new(self, 0, 0, @music)
    @player = Player.new(self, 475, 250)
    @enemies = Array.new
    @enemy_counter = 0
    @player_score = 0
    @life = Array.new
    @player_health = 4
    player_life
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


window = GameWindow.new
window.show
