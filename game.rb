require 'gosu'
require 'byebug'
require_relative 'mario_player.rb'

# Game initialization
class Game < Gosu::Window
  def initialize
    @screen_width = 236
    @screen_height = 236
    super @screen_width, @screen_height
    self.caption = 'Mario like'
    @background_x = 0
    @background = Gosu::Image.new('image/background.png', tileable: true)
    @player = Player.new
    @player.warp(0, 200)
    @jump_allow = true
    @x1, @y1 = 0, 0
  end

  def update
    if Gosu.button_down? Gosu::KB_LEFT
      @player.accelerate_left
      if (@player.player_coordinates_check[0] < @screen_width/2 - 5)
        @background_x -= @player.player_coordinates_check[2]
      end
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      @player.accelerate_right 
      if (@player.player_coordinates_check[0] > @screen_width/2 + 5)
        @background_x -= @player.player_coordinates_check[2]
      end
    end
    if Gosu.button_down? Gosu::KB_SPACE
      if @jump_allow == true
        @jump_allow = false
        @player.jump_initialization
      end
    end
    @jump_allow = @player.jump_allow_check
    @player.move(@screen_width, @background_x)
  end

  def draw
    @player.draw
    if (@background_x < 100 && @background_x - 256 > @background.width * -1)
      p @background_x
      @background_x = 0 if @background_x > 0 
      @background.draw(@background_x, 0, 0)
    end
  end

  def button_down(id)
    Gosu::window.close if id == Gosu::KbEscape
  end
end

my_game = Game.new
# my_game.fullscreen = true
my_game.show
