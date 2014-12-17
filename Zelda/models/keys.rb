module Keys
  def button_down(id)
    if id == Gosu::KbLeft
      binding.pry
      @player.go_left
      if id ==Gosu::KbA
        enemy_killed?
      end
    end

    if id == Gosu::KbRight
      @player.go_right
      if id ==Gosu::KbA
        enemy_killed?
      end
    end

    if id == Gosu::KbUp
      @player.go_up
      if id ==Gosu::KbA
        enemy_killed?

      end
    end

    if id == Gosu::KbDown
      @player.go_down
      if id ==Gosu::KbA
        enemy_killed?
      end
    end
  end
end
