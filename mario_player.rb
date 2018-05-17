# Player class
class Player
  def initialize
    @image = Gosu::Image.new('image/mario.png')
    @x = @y = @vel_x = @vel_y = 0.0
    @x_speed = 0.1
    @jump_height_delta = 0.8
    @jump_allow = true
    @jump_height = 25
  end

  def warp(x, y)
    @x = x
    @y = y
  end

  # Jump caracter method
  def jump_height_variation
    if @vel_y > 0
      jump_go_up
    elsif @vel_y < 0
      jump_go_down
    end
    check_jump
  end

  def jump_go_up
    @allow = false
    @vel_y.times do |index|
      p "Index = #{index} / UP = #{Gosu.offset_y(100, @vel_y/24.0)}"
      @y -= Gosu.offset_y(100, @vel_y/24.0)
    end
    @vel_y -= 1
  end

  def jump_go_down
    (@vel_y * -1).times do |index|
      p "Index = #{index} / Down = #{Gosu.offset_y(100, @vel_y/25*-1)}"
      @y += Gosu.offset_y(100, @vel_y/24.0*-1)
    end
    @vel_y += 1
  end

  def jump_initialization
    @vel_y = @jump_height
    @jump_allow = false
    @down_y = @jump_height * -1
  end

  def check_jump
    if @vel_y.zero? and @jump_allow == false
      @vel_y = @down_y
      @down_y = 0
    end
    if @vel_y == -1 and @jump_allow == false
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
  def move(screen_width)
    @x += @vel_x
    @x %= screen_width
    @vel_x *= 0.95
    jump_height_variation
  end

  # Draw caracter
  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end
end
