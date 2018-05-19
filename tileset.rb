require 'json'

# class Tileset
#   def initialize(window, json)
#   	@json = JSON.parse(File.read(json)) # Transforme le json en objet ruby
#   	# on join les strings
#   	# dirname : retourne les composants du fichier
#   	image_file = File.join( File.dirname(json), @json['meta']['image']) 
#   	@main_image = Gosu::Image.new(@window, image_file, true)
#   end

#   def frame(name)
#   	f = @json['frames']['name']['frame']
#   	@main_image.subimage(f['x'], f['y'], f['w'], f['h'])
#   end
# end

def json_quadrillage(json_file)
  @json_file = File.read(json_file)
  my_hash =JSON.parse(@json_file)
  my_new_array = my_hash["mon quadrillage"]
end

my_array = json_quadrillage('mario_tileset.json')

p my_array