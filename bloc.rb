# Bloc class
class Bloc
  attr_accessor :coordinates_array
  def initialize(bloc_x, bloc_y)
    @image = Gosu::Image.new('image/bloc.png')
    @bloc_x = bloc_x
    @bloc_y = bloc_y
    @width = 16
    @height = 16
    @coordinates_array = [@bloc_x, @bloc_y, @width, @height]
  end

  # NOT DONE
  def collision_top(player, background_x)    
    if (player[0] - player[4] /2 < @bloc_x + @width + background_x - 3) && (@bloc_x + @width + background_x - 3 < player[0] + player[4] / 2)
      if (@bloc_y < player[1] + player[5] /2)
        p 'shit 1'
        return true
      end
    elsif (@bloc_x + background_x - 3 < player[0] + player[4] / 2) && (player[0] + player[4] / 2 < @bloc_x + @width + background_x - 3)
      if (@bloc_y < player[1] + player[5] /2)
        p 'shit 2'
        return true
      end
      p 'shit 3'
    end
    return false
  end

  def collision_bottom(player, background_x)    
    if (player[0] - player[4] /2 < @bloc_x + @width + background_x - 3) && (@bloc_x + @width + background_x - 3 < player[0] + player[4] / 2)
      if (@bloc_y < player[1] + player[5] /2)
        p 'shit 1'
        return true
      end
    elsif (@bloc_x + background_x - 3 < player[0] + player[4] / 2) && (player[0] + player[4] / 2 < @bloc_x + @width + background_x - 3)
      if (@bloc_y < player[1] + player[5] /2)
        p 'shit 2'
        return true
      end
      p 'shit 3'
    end
    return false
  end

  def collision_right(player, background_x)    
      if (@bloc_y - @height - 10 < player[1] - player[5] / 2) && (player[1] - player[5] / 2 < @bloc_y + 10)
        if (@bloc_x + background_x - 3 < player[0] + player[4] /2 && @bloc_x + @width / 3 + background_x > player[0] - player[4] / 2)
          return true
        end
      elsif (player[1] - player[5] / 2 < @bloc_y + @height - 1) && (@bloc_y + @height + 1 < player[1] + player[5] / 2)
        if (@bloc_x + background_x - 3 < player[0] + player[4] /2 && @bloc_x + @width / 3 + background_x > player[0] - player[4] / 2)
          return true
        end
      end
      return false
  end

   def collision_left(player, background_x)    
      if (@bloc_y - @height - 10 < player[1] - player[5] / 2) && (player[1] - player[5] / 2 < @bloc_y + 10)
        if (@bloc_x + @width * 2 / 3 + background_x - 10 < player[0] + player[4] /2 && @bloc_x + @width + background_x > player[0] - player[4] / 2)
          return true
        end
      elsif (player[1] - player[5] / 2 < @bloc_y + @height - 1) && (@bloc_y + @height + 1 < player[1] + player[5] / 2)
        if (@bloc_x + @width * 2 / 3 + background_x - 10 < player[0] + player[4] /2 && @bloc_x + @width + background_x > player[0] - player[4] / 2)
          return true
        end
      end
      return false
  end
end
