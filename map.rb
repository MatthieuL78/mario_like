require 'gosu'
require 'json'

# Background and tileset class
class Map
  attr_accessor :background, :block_array
  # Our map is : 3392 width and 224 height
  # It s 212 tiles width and 14 tiles height
  TILE_SIZE = 16
  def initialize
    @tile_image = Gosu::Image.load_tiles('image/mario_world_1_1_tileset.png', TILE_SIZE, TILE_SIZE)
    @tile_array = json_quadrillage('mario_tileset.json')
    @background = Gosu::Image.new('image/mario_world_1_1_background_empty.png', tileable: true)
    @block_array = tile_to_block(@tile_array)
  end

  def json_quadrillage(json_file)
    @json_file = File.read(json_file)
    my_tile_hash = JSON.parse(@json_file)
    my_tile_hash['mon quadrillage_essai_bis']
  end

  def tile_to_block(tile_array)
    @my_array = []
    @row = -0.5
    @col = 0
    tile_array.map do |tile|
      if (@col % (@background.width / TILE_SIZE)).zero?
        @row += 1
        @col = 0
      end
      @my_array << Bloc.new(@col * TILE_SIZE, TILE_SIZE * @row) unless tile == 15
      @col += 1
    end
    @my_array
  end

  def draw(background_x)
    @row = -0.5
    @col = 0
    @background.draw(background_x, 0, 0)
    @tile_array.each do |tileset|
      if (@col % (@background.width / TILE_SIZE)).zero?
        @row += 1
        @col = 0
      end
      @tile_image[tileset - 1].draw(@col * TILE_SIZE + background_x, TILE_SIZE * @row, 0, 1, 1)
      @col += 1
    end
  end

  def background_width
    @background.width
  end
end
