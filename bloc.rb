# Bloc class
class Bloc
  def initialize(bloc_x, bloc_y)
    @image = Gosu::Image.new('image/bloc.png')
    @bloc_x = bloc_x
    @bloc_y = bloc_y
    @width = 16
    @height = 16
  end

  def collision(player, background_x)    
    return true if (player[0] - player[4] /2 < @bloc_x + @width + background_x && player[0] + player[4] / 2 > @bloc_x + background_x && player[1] - player[5] / 2 < @bloc_y + @height && player[1] + player[5] / 2 > @bloc_y)
    return false
  end

  def bloc_coordinates_check
    @coordinates_array = [@bloc_x, @bloc_y, @width, @height]
  end

end