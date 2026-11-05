extends MeshInstance3D

@export var grid_size: int = 16
@export var random_seed: int = 45326 # Set your constant seed here

func _ready() -> void:
	# 1. Create a FastNoiseLite instance
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_VALUE
	
	# 2. Assign a constant seed instead of randi()
	noise.seed = random_seed
	noise.frequency = 1.0
	
	# 3. Generate the 2D image texture
	var noise_image = NoiseTexture2D.new()
	noise_image.noise = noise
	noise_image.width = grid_size
	noise_image.height = grid_size
	noise_image.filter = true 
	
	# Wait for the texture generation to complete
	await noise_image.changed
	
	# 4. Apply the texture to the shader material
	var material = get_surface_override_material(0) as ShaderMaterial
	if material:
		material.set_shader_parameter("noise_texture", noise_image)
