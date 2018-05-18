# Bloc class
class Bloc
  def initialize
    @image = Gosu::Image.new('image/bloc.png')
    @bloc_x = @bloc_y = 0
    @width = 50
    @height = 10
  end

  def warp(init_x, init_y)
    @bloc_x = init_x
    @bloc_y = init_y
  end

  def draw
    @image.draw(@bloc_x, @bloc_y, 4, 4)
  end

  def collision(player)
    if (player[0] < @bloc_x + @width && player[0] + player[4] > @bloc_x && player[1] < @bloc_y + @height && player[1] + player[5] > @bloc_y)
      p 'PROUT AND CACA'
    end
  end
end