class BoundingBox
  attr_reader :left, :bottom, :width, :height, :right, :top

  def initialize(left, bottom, width, height)
    @left = left
    @bottom = bottom
    @width = width
    @height = height
    @right = @left + @width
    @top = @bottom + @height
  end

  def collide?(x, y)
    x >= left && x <= right && y >= bottom && y <= top
  end

  def intersects?(box)
    self.right > box.left && self.bottom < box.top && self.left < box.right && self.top > box.bottom
  end
end

# #exclusion boxes
#       if button_down? Gosu::KbUp
#         if (@player.x > 411 && @player.x < 560) && (@player.y > 0 && @player.y < 99)
#           @player.go_up
#         end
#         if button_down?Gosu::KbA
#           enemy_killed?
#         end
#       end
#
#       if button_down? Gosu::KbLeft
#         if (@player.x > 411 && @player.x < 560) && (@player.y > 0 && @player.y < 98)
#           @player.go_left
#         end
#         if button_down?Gosu::KbA
#           enemy_killed?
#         end
#       end
#
#       if button_down? Gosu::KbRight
#         if (@player.x > 411 && @player.x < 560) && (@player.y > 0 && @player.y < 98)
#           @player.go_right
#         end
#         if button_down?Gosu::KbA
#           enemy_killed?
#         end
#       end
#
#       if button_down? Gosu::KbDown
#         if (@player.x > 411 && @player.x < 560) && (@player.y > 0 && @player.y < 98)
#           @player.go_down
#         end
#         if button_down?Gosu::KbA
#           enemy_killed?
#         end
#       end
# #exclusion boxes
