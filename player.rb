# Player class
class Player
  def initialize
    @image = Gosu::Image.new('image/mario.png')
    @player_x = 50
    @player_y = 180
    @vel_x = @vel_y = 0.0
    @height = 33
    @width = 22
    @x_speed = 0.1
    @y_speed = 0.005
    @jump_delta = 0
    @jump_allow = true
    @jump_height_max = 30
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

  def jump_height_variation
    jump_go_up if @jump_delta > 0
    jump_go_down if @jump_delta < 0
    check_jump
  end

  def jump_go_up
    p " UP = #{@jump_delta}"
    @jump_delta.times do
      @vel_y -= Gosu.offset_y(100, @y_speed)
      @player_y -= @vel_y
    end
    p " UP = #{@vel_y}"
    @jump_delta -= 1
  end

  def jump_go_down
    p " DOWN = #{@jump_delta}"
    (@jump_delta * -1).times do
      # gravity
      @vel_y += Gosu.offset_y(100, @y_speed)
      @player_y += @vel_y
    end
    p " DOWN = #{@vel_y}"
    @jump_delta += 1
  end

  def check_jump
    return false unless @jump_allow == false
    if @jump_delta.zero?
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
  def move(sc_wdth, bg_x)
    # movement depending of the player_x
    if (@player_x > sc_wdth / 2 - 15 and Gosu.button_down? Gosu::KB_LEFT) or bg_x >= 0
      @player_x += @vel_x if @player_x > 2
    end
    # movement depending of the player_x
    if (@player_x < sc_wdth / 2 + 15 and Gosu.button_down? Gosu::KB_RIGHT) or bg_x <= -1595
      @player_x += @vel_x if @player_x < 234
    end
    # Block the ice effect
    @vel_x = 0 unless Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::KB_LEFT
    @player_x %= sc_wdth
    @vel_x *= 0.95
    jump_height_variation
  end

  # Character gravity
  def gravity
    # @vel_y += Gosu.offset_y(100, @y_speed)
    # @player_y += @vel_y * 100
  end

  # Character coordinates and velocity
  def player_coordinates_check
    @coordinates_array = [@player_x, @player_y, @vel_x, @vel_y, @width, @height]
  end

  # Character predictive coordinates
  def predictive_coordinates_check
    @coordinates_array = [@player_x + 1, @player_y - 1, @player_x - 1, @player_y + 1, @width, @height]
  end

  # Draw character
  def draw
    @image.draw_rot(@player_x, @player_y, 1, 0)
  end
end
