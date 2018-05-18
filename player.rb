# Player class
class Player
  def initialize
    @image = Gosu::Image.new('image/mario.png')
    @player_x = @player_y = @vel_x = @vel_y = 0.0
    @x_speed = 0.1
    @y_speed = 0.005
    @jump_delta = 0
    @jump_allow = true
    @jump_height = 25
  end
  
  # Teleport the caracter
  def warp(x, y)
    @player_x = x
    @player_y = y
  end

  # Jump character method
  def jump_height_variation
    if @jump_delta > 0
      jump_go_up
    elsif @jump_delta < 0
      jump_go_down
    end
    check_jump
  end

  def jump_go_up
    @allow = false
    @jump_delta.times do |index|
      @vel_y -= Gosu.offset_y(100, @y_speed)
      @player_y += @vel_y
    end
    @jump_delta -= 1
  end

  def jump_go_down
    (@jump_delta * -1).times do |index|
      @vel_y += Gosu.offset_y(100, @y_speed)
      @player_y += @vel_y
    end
    @jump_delta += 1
  end

  def jump_initialization
    @jump_delta = @jump_height
    @jump_allow = false
    @down_y = @jump_height * -1
  end

  def check_jump
    if @jump_delta.zero? and @jump_allow == false
      @vel_y = 0  
      @jump_delta = @down_y
      @down_y = 0
    end
    if @jump_delta == -1 and @jump_allow == false
      @vel_y = 0  
      @jump_allow = true
    end
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
  def move(screen_width, background_x)
    p "etape 3"
    # movement depending of the player_x
    if (@player_x > screen_width/2 - 15 and Gosu.button_down? Gosu::KB_LEFT) or background_x >= 0
      p "etape 4"
      if (@player_x > 2)
        p "etape 5"
        @player_x += @vel_x
      end
    end
    # movement depending of the player_x
    p "background_x = #{background_x}"
    if (@player_x < screen_width/2 + 15 and Gosu.button_down? Gosu::KB_RIGHT) or background_x <= -1595
      p "etape 4"
      p "background_x = #{background_x}"
      if (@player_x < 234)
        @player_x += @vel_x
        p "etape 5"
      end
    end
    
    # Block the ice effect
    unless Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::KB_LEFT
      @vel_x = 0
    end
    @player_x %= screen_width
    @vel_x *= 0.95
    jump_height_variation
  end
  
  # Caracter coordinates and velocity
  def player_coordinates_check
    @coordinates_array = [@player_x, @player_y, @vel_x, @vel_y]
  end

  # Draw caracter
  def draw
    @image.draw_rot(@player_x, @player_y, 1, 0)
  end
end
