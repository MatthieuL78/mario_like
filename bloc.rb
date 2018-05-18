# Bloc class
class Bloc
  def initialization
    @image = Gosu::Image.new('image/bloc.png')
    @bloc_x = @bloc_y = 0
    @width = 110
    @height = 180
  end

  def warp(init_x, init_y)
    @bloc_x = init_x
    @bloc_y = init_y
  end

  def draw
    @image.draw_rot(@bloc_x, @bloc_y, 1, 0)
  end

  # def collision(player, bloc)
  #   if (player.player_x < bloc.x + bloc.width && player.player_x + player.player_width > bloc.x
  #   	&& player.player_y < bloc.y + bloc.height && player.player_y + player.player_y > bloc.y) do
  #     player.image = nil
  #   end
  # end
end