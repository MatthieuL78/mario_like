require 'gosu'
require 'byebug'
require_relative 'player.rb'
require_relative 'bloc.rb'

# Game initialization
class Game < Gosu::Window
  def initialize
    @sc_wdth = 236
    @sc_hght = 236
    super @sc_wdth, @sc_hght
    self.caption = 'Mario like'
    @bg_x = 0
    @background = Gosu::Image.new('image/background.png', tileable: true)
    @player = Player.new
    @player.warp(50, 200)
    @jump_allow = true
    @bloc = Bloc.new
    @bloc.warp(150, 150)
  end

  def update
    # player go left
    if Gosu.button_down? Gosu::KB_LEFT
      @player.accelerate_left
      # movement depending of the background
      if @player.player_coordinates_check[0] < @sc_wdth / 2 - 15
        @bg_x -= @player.player_coordinates_check[2]
      end
    end
    # player go right
    if Gosu.button_down? Gosu::KB_RIGHT
      @player.accelerate_right
      # movement depending of the background
      if @player.player_coordinates_check[0] > @sc_wdth / 2 + 15
        @bg_x -= @player.player_coordinates_check[2]
      end
    end
    # player jump
    if Gosu.button_down? Gosu::KB_SPACE
      if @jump_allow == true
        @jump_allow = false
        @player.jump_initialization
      end
    end
    #@bloc.collision(@player,@bloc)
    @jump_allow = @player.jump_allow_check
    @player.move(@sc_wdth, @bg_x)
  end

  def draw
    @player.draw
    p @bloc
    #@bloc.draw
    return false unless @bg_x < 100 && @bg_x - 256 > @background.width * -1
    # we block the extremities of the background
    @bg_x = 0 if @bg_x > 0
    @bg_x = -1595 if @bg_x < -1595
    @background.draw(@bg_x, 0, 0)
  end

  def button_down(id)
    Gosu::window.close if id == Gosu::KbEscape
  end
end

my_game = Game.new
# my_game.fullscreen = true
my_game.show
