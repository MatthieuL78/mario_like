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
    @background_image = Gosu::Image.new('image/background.png', tileable: true)
    @player = Player.new
    @player.warp(100, 200)
    @jump_allow = true
  end

  def update
    @player.accelerate_left if Gosu.button_down? Gosu::KB_LEFT
    @player.accelerate_right if Gosu.button_down? Gosu::KB_RIGHT
    if Gosu.button_down? Gosu::KB_SPACE
      if @jump_allow == true
        @jump_allow = false
        @player.jump_initialization
      end
    end
    @jump_allow = @player.jump_allow_check
    @player.move(@screen_width)
  end

  def draw
    @player.draw
    @background_image.draw(0, 0, 0)
  end
end

my_game = Game.new
my_game.fullscreen = true
my_game.show
