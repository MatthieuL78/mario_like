# Bloc class
class Bloc
  def initialize(bloc_x, bloc_y)
    @image = Gosu::Image.new('image/bloc.png')
    @bloc_x = bloc_x
    @bloc_y = bloc_y
    @width = 16
    @height = 16
  end

  def collision(player)
    if (player[0] < @bloc_x + @width && player[0] + player[4] > @bloc_x && player[1] < @bloc_y + @height && player[1] + player[5] > @bloc_y)
      return p true
    end
    # return p false
  end
end