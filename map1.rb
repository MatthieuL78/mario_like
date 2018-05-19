require 'gosu'
require 'json'

# def media_path(file)
#   File.join(File.dirname(File.dirname(__FILE__)), 'media', file)
# end

class GameWindow < Gosu::Window
  # Our map is : 3392 width and 224 height
  # It s 212 tiles width and 14 tiles height
  WIDTH = 236
  HEIGHT = 236
  TILE_SIZE = 16

  def json_quadrillage(json_file)
    @json_file = File.read(json_file)
    my_hash =JSON.parse(@json_file)
    my_new_array = my_hash["mon quadrillage"]
  end

  def initialize
  	super(WIDTH, HEIGHT, false)
  	self.caption = 'map1'
  	@tileset_image = Gosu::Image.load_tiles('image/mario_world_1_1_tileset.png', TILE_SIZE, TILE_SIZE)
  	@tileset_array = json_quadrillage('mario_tileset.json')
    @background = Gosu::Image.new('image/background.png', tileable: true)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def draw
    @row = 0
    @col = 0
    @background.draw(0, 0, 0)
    @tileset_array.each do |tileset|
      # if @col % (WIDTH / TILE_SIZE)== 0
      if @col % 15 == 0
        @row += 1 
        @col = 0
      end
  	  @tileset_image[tileset - 1].draw(@col * TILE_SIZE, TILE_SIZE * @row, 0, 1, 1)
      @col += 1
    end
  end
end

window = GameWindow.new
window.fullscreen = true
window.show