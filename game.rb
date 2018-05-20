require 'gosu'
require 'byebug'
require_relative 'map.rb'
require_relative 'player.rb'
require_relative 'bloc.rb'

# Game initialization
class Game < Gosu::Window
  WIDTH = 236
  HEIGHT = 236
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Mario like'
    @bg_x = 0
    # @background = Gosu::Image.new('image/background.png', tileable: true)
    @map = Map.new
    @map.json_quadrillage('mario_tileset.json')
    @player = Player.new
    @player.warp(50, 200)
    @jump_allow = true
    # @bloc = Bloc.new
    # @bloc.warp(100, 100)
  end

  def update
    # player go left
    if Gosu.button_down? Gosu::KB_LEFT
      @player.accelerate_left
      # movement depending of the background
      if @player.player_coordinates_check[0] < WIDTH / 2 - 15
        @bg_x -= @player.player_coordinates_check[2]
      end
    end
    # player go right
    if Gosu.button_down? Gosu::KB_RIGHT
      @player.accelerate_right
      # movement depending of the background
      if @player.player_coordinates_check[0] > WIDTH / 2 + 15
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
    #unless @bloc.collision(@player.player_coordinates_check) == true
      @player.move(WIDTH, @bg_x)
    #end
  end

  def draw
    @player.draw
    # @bloc.draw
    return false unless @bg_x < 100 && @bg_x - 256 > @map.background_width * -1
    # we block the extremities of the background
    @bg_x = 0 if @bg_x > 0
    @bg_x = -1595 if @bg_x < -1595
    #@map.draw(@bg_x, 0, 0)
    @map.draw(@bg_x)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

my_game = Game.new
# my_game.fullscreen = true
my_game.show
