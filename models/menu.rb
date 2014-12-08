class Menu
  attr_accessor :selection, :menu_action

  def initialize(window, x, y)
    @window = window
    @y = y
    @x = x

    @bg_image = Gosu::Image.new(window, 'img/title_back.png')
    @title = Gosu::Image.new(window, 'img/title_screen.png')
    # @selection = 1
    @menu_action = nil
  end

  def draw
    @bg_image.draw(@x, @y, 0)
    @title.draw(@x, @y, 0)
  end

  def update
    @menu_action
  end
end
