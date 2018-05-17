# Player class
class Player
  def initialize
    @image = Gosu::Image.new('image/mario.png')
    @x = @y = @vel_x = @vel_y = 0.0
    @x_speed = 0.1
    @y_speed = 0.005
    @timer = 0
    @jump_allow = true
    @jump_height = 25
  end

  def warp(x, y)
    @x = x
    @y = y
  end

  # Jump caracter method
  def jump_height_variation
    if @timer > 0
      jump_go_up
    elsif @timer < 0
      jump_go_down
    end
    check_jump
  end

  def jump_go_up
    @allow = false
    @timer.times do |index|
      @vel_y -= Gosu.offset_y(100, @y_speed)
      @y += @vel_y
    end
    @timer -= 1
  end

  def jump_go_down
    (@timer * -1).times do |index|
      @vel_y += Gosu.offset_y(100, @y_speed)
      @y += @vel_y
    end
    @timer += 1
  end

  def jump_initialization
    @timer = @jump_height
    @jump_allow = false
    @down_y = @jump_height * -1
  end

  def check_jump
    if @timer.zero? and @jump_allow == false
      @vel_y = 0  
      @timer = @down_y
      @down_y = 0
    end
    if @timer == -1 and @jump_allow == false
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
