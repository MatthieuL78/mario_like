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
    @player.warp(50, 150)
    @jump_allow = true
    @gravity = false
    @collision_side = false
    @move_right = true
    @move_left = true
  end

  def update
    # player go left
    unless @move_left == false
      if Gosu.button_down? Gosu::KB_LEFT
        @move_right = true
        @map.block_array.each do |bloc|
          if bloc.collision_left(@player.coordinates_predictives, @bg_x) == false
            @move_left = true
          else
            @move_left = false 
            break
          end 
        end
        if @move_left == true
          @player.accelerate_left
          # movement depending of the background
          if @player.coordinates[0] < WIDTH / 2 - 15
            @bg_x -= @player.coordinates[2]
          end
        end
      end
    end

    # player go right
    unless @move_right == false
      if Gosu.button_down? Gosu::KB_RIGHT
        @move_left = true
        @map.block_array.each do |bloc|
          if bloc.collision_right(@player.coordinates_predictives, @bg_x) == false
            @move_right = true
          else
            @move_right = false 
            break
          end 
        end
        if @move_right == true
          @player.accelerate_right
          # movement depending of the background
          if @player.coordinates[0] > WIDTH / 2 + 15
            @bg_x -= @player.coordinates[2]
          end
        end
      end
    end

    # player jump
    if Gosu.button_down? Gosu::KB_SPACE
      if @jump_allow == true
        @jump_allow = false
        @gravity = true
        @player.jump_initialization
      end
    end
    
    # Check the gravity
    unless @jump_allow == false
      @map.block_array.each do |bloc|
        if bloc.collision_bottom(@player.coordinates_predictives, @bg_x) == true
          # p @player.predictive_coordinates_check
          # p bloc.bloc_coordinates_check
          @gravity = false
          @player.coordinates[3] = 0
          # byebug
          break
        end
        @gravity = true
      end
      if @gravity == true  
        @player.gravity
      end
      # Check if jump is allowed
    end
    
    
      @jump_allow = @player.jump_allow_check
      @player.move(WIDTH, @bg_x, @move_right, @move_left)
    
  end

  def draw
    @player.draw
    return false unless @bg_x < 100 && @bg_x - 256 > @map.background_width * -1
    # we block the extremities of the background
    @bg_x = 0 if @bg_x > 0
    @bg_x = -1595 if @bg_x < -1595
    # We drow the background and tiles
    @map.draw(@bg_x)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

my_game = Game.new
# my_game.fullscreen = true
my_game.show
