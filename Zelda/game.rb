#  todo:
  #  water enemy / bullets
  #  **  fix health meter increase and decrease  **
  #  put spawned hearts on a timer
  #  difficulty increase
  #  boarder collisions
  #  two hit enemies

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
    @title = Gosu::Image.new(self, 'img/title_screen.png')
    @instructions = Gosu::Image.new(self, 'img/instructions.png')
    @game_over = Gosu::Image.new(self, 'img/game_over.png')
    @player = Player.new(self, 600, 350)
    @player.warp(500, 240)
    @enemies = Array.new
    @enemy_counter = 0
    # @water_enemies = Array.new
    # @water_enemies_counter = 0
    # @menu = Menu.new(self, 0, 0, @music, @image)
    @state = :menu
    @background = Background.new(self, 0, 0)
    @music = true
    @score_font = Gosu::Font.new(self, "Avenir", 450 / 15)
    @player_score = 0
    @life = Array.new
    @player_health = 4
    player_life

    @heart_arr = Array.new
    @heart_counter = 0

    # @collision = nil
    # @new_pos = @player.move

    # @bounds_arr = [BoundingBox.new(0, 520, 94, 520),
    # BoundingBox.new(94, 98, 317, 98),
    # BoundingBox.new(600, 98, 400, 98),
    # BoundingBox.new(94, 520, 317, 80),
    # BoundingBox.new(600, 520, 400, 80)]

  end

  def update
    if @state == :menu || @state == :instructions
      @background.menu_music.play
    else
      @background.menu_music.pause
    end

    # if @state == :instructions
    #   @background.menu_music.play
    # else
    #   @background.menu_music.pause
    # end


    if @state == :running
      @background.game_music.play
    else
      @background.game_music.pause
    end

    if @state == :game_over
      @background.game_over_music.play
    else
      @background.game_over_music.pause
    end

    if @state == :menu
      if button_down? Gosu::KbSpace
        @state = :instructions
      end
    end

    if @state == :instructions
      if button_down? Gosu::KbReturn
        @state = :running
      end
    end

    if @state == :game_over
      if button_down? Gosu::KbReturn
        @state = :lose
      end
    end


    if @state == :running

      # if @background.water.collide?(@player.x, @player.y)
      #   @player.stop
      # else


      # borders?
      # if @collision == true
      #   @player.stop
      # end

          if button_down? Gosu::KbLeft
            # if @collision != true
              @player.go_left
              if button_down?Gosu::KbA
                enemy_killed?
              end
          #   end
          end

          if button_down? Gosu::KbRight
            @player.go_right
            if button_down?Gosu::KbA
              enemy_killed?

            end
          end
          if button_down? Gosu::KbUp
            @player.go_up
            if button_down?Gosu::KbA
              enemy_killed?

            end
          end
          if button_down? Gosu::KbDown
            @player.go_down
            if button_down?Gosu::KbA
              enemy_killed?

            end
          end



        @player.move


      @enemy_counter += 1
      @heart_counter += 1




#enemy
      summon_enemies
      @enemies.each {|enemy| enemy.update}
      player_killed?

#health
      drop_heart

       heart_pickup?
        if @health_increase
            player_life
        end

#health

    end

    if @state == :lose
      reset
      @state = :menu
    end

  end




  def draw

    if @state == :menu
      @title.draw(0, 0, 1)
    end

    if @state == :instructions
      @instructions.draw(0, 0, 3)
    end

    if @state == :game_over
      @game_over.draw(0, 0, 1)
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

      @heart_arr.each do |heart|
        heart.draw
      end

      if @hit == true
        @background.sfx_player_hit.play
        @life.pop
      end

      if @health_increase == true
        @background.sfx_player_life.play
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

    if @enemy_counter % 50 == 0
      y_spawn_arr = Array.new
      points_arr = [110..120, 200..210, 290..300, 380..390]

      points_arr.each do |x|
        y_spawn_arr << x.to_a
      end

      y_spawn = y_spawn_arr.flatten!

      x_spawn = (415..560).to_a

      if x_entry_point == 86 || y_entry_point == -30
        speed = (2..3).to_a
        if x_entry_point == 86
          image = Gosu::Image.new(self, "img/enemy_right.png", false)
        elsif y_entry_point == -30
          image = Gosu::Image.new(self, "img/enemy_down.png", false)
        end
      elsif x_entry_point == 1050 || y_entry_point == 540
        speed = (-3..-2).to_a
        if x_entry_point == 1050
          image = Gosu::Image.new(self, "img/enemy.png", false)
        elsif y_entry_point == 540
          image = Gosu::Image.new(self, "img/enemy_up.png", false)
        end
      end

      number = (1..10).to_a
      if number.sample > 5
        @enemies << Enemy.new(self, x_entry_point, y_spawn.sample, :horizontal, speed.sample, image)
      else
        @enemies << Enemy.new(self, x_spawn.sample, y_entry_point, :vertical, speed.sample, image)
      end
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
          @state = :game_over
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

  def player_life
    x1 = 733
    y1 = 26
    @player_health.times do
      @life << Life.new(self, x1, y1)
      x1 += 30
    end
  end

  def drop_heart
    if @heart_counter % 600 == 0
      x_number = (110..900).to_a
      y_number = (110..420).to_a
      @heart_arr << Life.new(self, x_number.sample, y_number.sample)
    end
  end

  def heart_pickup?
    @health_increase = nil
    heart_in_arr = nil
    @heart_arr.each do |heart|
      if heart.bounds.intersects?(@player.bounds)
        heart_in_arr = heart
        @health_increase = true
        if @player_health < 4
          @player_health += 1
        end
        break
      end
    end
    @heart_arr.delete(heart_in_arr)
  end


    # def borders?
    #   @collion = nil
    #   @bounds_arr.each do |nono_square|
    #     if @player.bounds.intersects?(nono_square)
    #      @collision = true
    #     end
    #   end
    # end

  def reset
    @menu = Menu.new(self, 0, 0, @music)
    @player = Player.new(self, 475, 250)
    @enemies = Array.new
    @enemy_counter = 0
    @player_score = 0
    @life = Array.new
    @player_health = 4
    player_life
    @heart_counter = 0
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


window = GameWindow.new
window.show
