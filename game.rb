require 'rubygems' # only necessary in Ruby 1.8
require 'gosu'
require 'pry'

require_relative 'models/player'
require_relative 'models/enemy'
require_relative 'models/bounding_box'
# require_relative 'models/menu'


class GameWindow < Gosu::Window
  def initialize
    super(1000, 520, false)
    self.caption = 'Link Zombie Battle HD2000'

    @background_image = Gosu::Image.new(self, "img/water_background.png", true)
    @player = Player.new(self)
    @player.warp(320, 240)
    @enemies = Array.new
    @enemy_counter = 0
    # @menu = Menu.new(self, 0, 0)
  end

  def update
    # menu_action = @menu.update
    # if menu_action == "start"
    #   @state = :running
    # end
    # @menu.menu_action = nil
    #
    # if @state == :running

      if button_down? Gosu::KbLeft then
        @player.go_left
        # change to img/
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
      @enemy_counter += 2
      summon_enemies
      @enemies.each {|enemy| enemy.update}
      player_killed?
    # end

    # if @state == :lose
    #   @enemies.each {|e| e.state == :pause}
    # end

  end

  def draw
    # @menu.draw if @state == :menu

    # if @state != :menu
    #   if @state == :running
    @player.draw
    @background_image.draw(0, 0, 0)
    @enemies.each {|enemy| enemy.draw}
    #   end
    # end

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
    # player_health = 5
    @enemies.each do |enemy|
      if enemy.bounds.intersects?(@player.bounds)
        # player_health -= 1
        # @state = :lose
        exit
      end
    end
  end

  # def reset(state)
  #   @menu = Menu.new(self, 0, 0)
  #   @player = Player.new(self, 400, 50)
  #   # @state = state
  #   # @game_end = nil
  # end



  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


window = GameWindow.new
window.show
