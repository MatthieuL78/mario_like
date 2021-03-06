# Player class
class Player
  attr_accessor :coordinates, :coordinates_predictives, :vel_y
  def initialize
    @image = Gosu::Image.new('image/mario.png')
    @player_x = 40
    @player_y = 50
    @vel_x = @vel_y = 0.0
    @height = 33
    @width = 22
    @x_speed = 0.1
    @y_speed = 0.005
    @jump_delta = 0
    @jump_allow = true
    @jump_height_max = 25
    @coordinates = [@player_x, @player_y, @vel_x, @vel_y, @width, @height]
    @coordinates_predictives = [@player_x + 1, @player_y + 1, @player_x - 1, @player_y - 1, @width, @height]
    @jump_top = true
  end

  # Teleport the caracter
  def warp(init_x, init_y)
    @player_x = init_x
    @player_y = init_y
  end

  # Jump character method
  def jump_initialization
    @jump_delta = @jump_height_max
    @jump_allow = false
    @vel_y = jump_velocity_max(@jump_height_max)
    @down_y = @jump_height_max * -1
  end

  def jump_height_variation(bloc_array, gravity, bg_x)
    jump_go_up(bloc_array, bg_x) if @jump_delta > 0
    jump_go_down(bloc_array, gravity, bg_x) if @jump_delta < 0
    check_jump(gravity)
  end

  def jump_go_up(bloc_array, bg_x)
    @jump_delta.times do
      # stop by block
      bloc_array.each do |bloc|
        unless bloc.bloc_array[1] + bloc.bloc_array[3] > @player_y
          if bloc.collision_top(@coordinates_predictives, bg_x) == true
            @jump_top = false
            @vel_y = 0
            break
          end
        end
      end
      unless @jump_top == false
        @vel_y -= Gosu.offset_y(100, @y_speed)
        @player_y -= @vel_y
      end
    end
    @jump_delta -= 1
  end

  def jump_go_down(bloc_array, gravity, bg_x)
    (@jump_delta * -1).times do
      # gravity
      bloc_array.each do |bloc|
        if bloc.collision_bottom(@coordinates_predictives, bg_x) == true
          gravity = false
          @vel_y = 0
          @jump_delta == -2
          break
        end
      end   
      @vel_y += Gosu.offset_y(100, @y_speed)
      @player_y += @vel_y
    end
    @jump_delta += 1
  end

  def check_jump(gravity)
    return false unless @jump_allow == false
    if @jump_delta.zero? || @jump_top == false
      @vel_y = 0
      @jump_delta = @down_y
      @down_y = 0
    elsif @jump_delta == -1
      @vel_y = 0
      @jump_allow = true
    end
  end

  def jump_velocity_max(jump_height_max)
    jump_height_max.times do
      jump_height_max.times do
        @vel_y += Gosu.offset_y(100, @y_speed)
      end
      jump_height_max -= 1
    end
    @vel_y
  end

  def jump_allow_check
    @jump_allow
  end

  # Right and Left caracter method
  def accelerate_right
    @vel_x += Gosu.offset_x(100, @x_speed)
  end

  def accelerate_left
    @vel_x -= Gosu.offset_x(100, @x_speed)
  end

  # Caracter movement
  def move(sc_wdth, bg_x, move_right, move_left, bloc_array, gravity)
    # movement depending of the player_x
    # NEED TO CHECK THE OFFSET OF 15, this value is needed
    if (@player_x > sc_wdth * 1 / 2 - 15 and Gosu.button_down? Gosu::KB_LEFT and move_left == true) or bg_x >= 0
      @player_x += @vel_x if @player_x > 2
    else
      false
    end
    # movement depending of the player_x
    # NEED TO CHECK THE OFFSET OF 15, this value is needed
    if (@player_x < sc_wdth * 1 / 2 + 15 and Gosu.button_down? Gosu::KB_RIGHT and move_right == true) or bg_x <= -1595
      @player_x += @vel_x if @player_x < 234
    else
      false
    end
    # Block the ice effect
    # @vel_x = 0 unless Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::KB_LEFT
    # @vel_x = 0 unless Gosu.button_down? Gosu::KB_RIGHT and Gosu.button_down? Gosu::KB_LEFT
    # @player_x %= sc_wdth

    # We decrease the velocity
    # @vel_x *= 0.8
    
    # If jump_delta is equal 0 it's not do
    # jump_height_variation(bloc_array, gravity, bg_x) unless @jump_delta.zero?

    @coordinates = [@player_x, @player_y, @vel_x, @vel_y, @width, @height]
    @coordinates_predictives = [@player_x + 1, @player_y - 1, @player_x - 1, @player_y + 1, @width, @height]
  end

  # Character gravity
  def gravity
    @vel_y += Gosu.offset_y(100, @y_speed)
    @player_y += @vel_y * 25
    @coordinates = [@player_x, @player_y, @vel_x, @vel_y, @width, @height]
    @coordinates_predictives = [@player_x + 1, @player_y - 1, @player_x - 1, @player_y + 1, @width, @height]
  end

  # Draw character
  def draw
    @image.draw_rot(@player_x, @player_y, 1, 0)
  end
end
