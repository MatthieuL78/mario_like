# Bloc class
class Bloc
  attr_accessor :bloc_array
  def initialize(bloc_x, bloc_y)
    @image = Gosu::Image.new('image/bloc.png')
    @bloc_x = bloc_x
    @bloc_y = bloc_y
    @width = 16
    @height = 16
    @bloc_array = [@bloc_x, @bloc_y, @width, @height]
    @player_array = [0, 0, 0, 0]
  end

  # NOT DONE
  def collision_top(player, background_x)
    # p  @bloc_y + @height
    # p player[1] - player[5] /2
    player_left_side = player[0] - player[4] / 2
    player_right_side = player[0] + player[4] / 2
    player_top_side = player[1] - player[5] / 2

    if (player_left_side < @bloc_x + @width + background_x - 3) && (@bloc_x + @width + background_x - 3 < player_right_side)
      if @bloc_y + @height > player_top_side
        p 'shit 1'
        return true
      end
    elsif (@bloc_x + background_x - 3 < player_right_side) && (player_right_side < @bloc_x + @width + background_x - 3)
      if @bloc_y + @height > player_top_side
        p 'shit 2'
        return true
      end
      p 'shit 3'
    end
    false
  end

  def collision_bottom(player, background_x)
    # p @bloc_y
    # p player[1] + player[5] /2
    player_left_side = player[0] - player[4] / 2
    player_right_side = player[0] + player[4] / 2
    player_bottom_side = player[1] + player[5] / 2

    if (player_left_side < @bloc_x + @width + background_x - 3) && (@bloc_x + @width + background_x - 3 < player_right_side)
      if @bloc_y < player_bottom_side
        # p 'shit 1'
        return true
      end
    elsif (@bloc_x + background_x - 3 < player_right_side) && (player_right_side < @bloc_x + @width + background_x - 3)
      if @bloc_y < player_bottom_side
        # p 'shit 2'
        return true
      end
      # p 'shit 3'
    end
    false
  end

  def collision_right(player, background_x)
    player_sides(player, 'RIGHT')

    if (@bloc_y - @height - 10 < @player_array[0]) && (@player_array[0] < @bloc_y + 10)
      if (@bloc_x + background_x < @player_array[1] && @bloc_x + @width / 3 + background_x > @player_array[3])
        p 'colision 1'
        return true
      end
    elsif (@player_array[0] < @bloc_y + @height - 1) && (@bloc_y + @height + 1 < @player_array[2])
      if (@bloc_x + background_x < @player_array[1] && @bloc_x + @width / 3 + background_x > @player_array[3])
        p 'colision 2'
        return true
      end
    end
    false
  end

  def collision_left(player, background_x)
    player_sides(player, 'LEFT')
    if (@bloc_y - @height - 10 < @player_array[0]) && (@player_array[0] < @bloc_y + 10)
      if (@bloc_x + @width + background_x < @player_array[1] && @bloc_x + @width + background_x > @player_array[3])
        return true
      end
    elsif (@player_array[0] < @bloc_y + @height - 1) && (@bloc_y + @height + 1 < @player_array[0])
      if (@bloc_x + @width + background_x < @player_array[1] && @bloc_x + @width + background_x > @player_array[3])
        return true
      end
    end
    false
  end

  def player_sides(player, direction)
    # Top - Right - Bottom - Left
    # If we go LEFT, the predictive is on the left (negative)
    if direction == 'LEFT'
      @player_array[1] = player[0] + player[4] / 2
      @player_array[3] = player[2] - player[4] / 2
    # If we go RIGHT, the predictive is on the right (positive)
    elsif direction == 'RIGHT'
      @player_array[1] = player[0] + player[4] / 2
      @player_array[3] = player[0] - player[4] / 2
    end
    @player_array[0] = player[1] - player[5] / 2
    @player_array[2] = player[1] + player[5] / 2
  end

  def bloc_sides(bloc)
  # Top - Right - Bottom - Left
    @player_array[0] = player[1] - player[5] / 2
    @player_array[1] = player[0] + player[4] / 2
    @player_array[2] = player[1] + player[5] / 2
    @player_array[3] = player[0] - player[4] / 2
  end

end
