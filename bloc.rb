# Bloc class
class Bloc
  attr_accessor :bloc_array, :predictive_array
  def initialize(bloc_x, bloc_y)
    @image = Gosu::Image.new('image/bloc.png')
    @bloc_x = bloc_x
    @bloc_y = bloc_y
    @width = 16
    @height = 16
    @bloc_array = [@bloc_x, @bloc_y, @width, @height]
    @predictive_bloc = [0, 0, 0, 0]
    @player = [0, 0, 0, 0]
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
    player_sides(player, 'Y')
    bloc_sides(background_x)
    if (@player[0] < @predictive_bloc[0]) && (@predictive_bloc[0] < @player[2])
      return true if @predictive_bloc[3] < @player[3] && @player[3] < @predictive_bloc[1]
      return true if @player[3] < @predictive_bloc[3] && @predictive_bloc[3] < @player[1]
    end
    # if (@player[3] < @bloc_x + @width + background_x - 3) && (@bloc_x + @width + background_x - 3 < @player[1])
    #   if @bloc_y < @player[2]
    #     # p 'shit 1'
    #     return true
    #   end
    # elsif (@bloc_x + background_x - 3 < @player[1]) && (@player[1] < @bloc_x + @width + background_x - 3)
    #   if @bloc_y < @player[2]
    #     # p 'shit 2'
    #     return true
    #   end
    #   # p 'shit 3'
    # end
    false
  end

  def collision_right(player, background_x)
    player_sides(player, 'X')
    bloc_sides(background_x)
    if @predictive_bloc[3] < @player[1] && @predictive_bloc[3] > @player[3]
      return true if @predictive_bloc[0] < @player[0] && @player[0] < @predictive_bloc[2]
      return true if @player[0] < @predictive_bloc[0] && @predictive_bloc[0] < @player[2]
    end
    false
  end

  def collision_left(player, background_x)
    # NEED TO CHECK WHY @width / 1.4 ?!
    player_sides(player, 'X')
    bloc_sides(background_x)
    if @predictive_bloc[1] < @player[1] && @predictive_bloc[1] > @player[3]
      return true if @predictive_bloc[0] < @player[0] && @player[0] < @predictive_bloc[2]   
      return true if @player[0] < @predictive_bloc[0] && @predictive_bloc[0] < @player[2]    
    end
    false
  end

  def player_sides(player, axe)
    if axe == 'X'
      @player[0] = player[3] + 1 - player[5] / 2
      @player[2] = player[1] - 1 + player[5] / 2
    elsif axe == 'Y'
      @player[0] = player[3] - player[5] / 2
      @player[2] = player[1] + player[5] / 2
    end
      @player[1] = player[0] + player[4] / 2
      @player[3] = player[2] - player[4] / 2
  end

  def bloc_sides(background_x)
  # Top - Right - Bottom - Left
    # if direction == 'LEFT'
    #   @predictive_bloc[1] = @bloc_array[0] + @bloc_array[2] / 1.4 + background_x
    #   @predictive_bloc[0] = @bloc_array[1] - @bloc_array[3] - 10
    # elsif direction == 'RIGHT'
    #   @predictive_bloc[1] = @bloc_array[0] + @bloc_array[2] / 3 + background_x
    #   @predictive_bloc[0] = @bloc_array[1] + @bloc_array[3] - 10
    # end
    @predictive_bloc[0] = @bloc_array[1]
    @predictive_bloc[1] = @bloc_array[0] + @bloc_array[2] / 1.4 + background_x
    @predictive_bloc[2] = @bloc_array[1] + @bloc_array[3]
    @predictive_bloc[3] = @bloc_array[0] + background_x
  end

end
