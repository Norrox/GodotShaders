tool
extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mat
var val = 10.0
# Called when the node enters the scene tree for the first time.
func _ready():
	mat = self.get_material()
	mat.set_shader_param("seed",randi() % 10000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(0.11*delta)
	
	#mat.set_shader_param("seed",val)
	#val += 0.01
