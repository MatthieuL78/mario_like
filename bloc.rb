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

  # TOUT METTRE EN 1 fonction
  def collision_top(player, background_x)
    player_sides(player, 'Y')
    bloc_sides(background_x)
    if (@predictive_bloc[0] < @player[0]) && (@player[0] > @predictive_bloc[2])
      return true if @predictive_bloc[3] < @player[3] && @player[3] < @predictive_bloc[1]
      return true if @player[3] < @predictive_bloc[3] && @predictive_bloc[3] < @player[1]
    end
    false
  end

  def collision_bottom(player, background_x)
    player_sides(player, 'Y')
    bloc_sides(background_x)
    if (@predictive_bloc[0] < @player[2]) && (@player[2] < @predictive_bloc[2])
      return true if @predictive_bloc[3] < @player[3] && @player[3] < @predictive_bloc[1]
      return true if @player[3] < @predictive_bloc[3] && @predictive_bloc[3] < @player[1]
    end
    false
  end

  def collision_right(player, background_x)
    player_sides(player, 'X')
    bloc_sides(background_x)
    if @player[3] < @predictive_bloc[3] && @predictive_bloc[3] < @player[1]
      return true if @predictive_bloc[0] < @player[0] && @player[0] < @predictive_bloc[2]
      return true if @player[0] < @predictive_bloc[0] && @predictive_bloc[0] < @player[2]
    end
    false
  end

  def collision_left(player, background_x)
    player_sides(player, 'X')
    bloc_sides(background_x)
    if @predictive_bloc[3] < @player[3] && @player[3] < @predictive_bloc[1]
      return true if @predictive_bloc[0] < @player[0] && @player[0] < @predictive_bloc[2]   
      return true if @player[0] < @predictive_bloc[0] && @predictive_bloc[0] < @player[2]    
    end
    false
  end

  def player_sides(player, axe)
    if axe == 'X'
      @player[0] = player[3] + 1 - player[5] / 2
      @player[1] = player[0] + player[4] / 2
      @player[2] = player[1] - 1 + player[5] / 2
      @player[3] = player[2] - player[4] / 2
    elsif axe == 'Y'
      @player[0] = player[3] - player[5] / 2
      @player[1] = player[0] - 1 + player[4] / 2
      @player[2] = player[1] + player[5] / 2
      @player[3] = player[2] + 1 - player[4] / 2
    end
  end

  def bloc_sides(background_x)
    @predictive_bloc[0] = @bloc_array[1]
    # NEED TO CHECK WHY @width / 1.4 ?!
    @predictive_bloc[1] = @bloc_array[0] + @bloc_array[2] / 1.4 + background_x
    @predictive_bloc[2] = @bloc_array[1] + @bloc_array[3]
    @predictive_bloc[3] = @bloc_array[0] + background_x
  end

end
