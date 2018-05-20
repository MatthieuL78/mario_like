require 'gosu'
require 'json'

# Background and tileset class
class Map
  TILE_SIZE = 16
  def initialize
    @tile_image = Gosu::Image.load_tiles('image/mario_world_1_1_tileset.png', TILE_SIZE, TILE_SIZE)
    @tile_array = json_quadrillage('mario_tileset.json')
    @background = Gosu::Image.new('image/background.png', tileable: true)
  end

  def json_quadrillage(json_file)
    @json_file = File.read(json_file)
    my_tile_hash =JSON.parse(@json_file)
    my_tile_array = my_tile_hash["mon quadrillage"]
  end

  def draw(width, background_x)
    @row = 0
    @col = 0
    @background.draw(background_x, 0, 0)
    @tile_array.each do |tileset|
      # if @col % (width / TILE_SIZE)== 0
      if @col % 15 == 0
        @row += 1 
        @col = 0
      end
      @tile_image[tileset - 1].draw(@col * TILE_SIZE, TILE_SIZE * @row, 0, 1, 1)
      @col += 1
    end
  end

  def background_width
    @background.width
  end
end
