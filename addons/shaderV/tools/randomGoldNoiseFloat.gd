tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloatGoldenRation

func _get_name():
	return "RandomGoldRatio"

func _get_category():
	return "Tools"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Random float based on golden ratio"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return 3

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "seed"

func _get_input_port_type(port: int):
	set_input_port_default_value(0, Vector3(0, 0, 0))
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 0.0)
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "rand"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_code(input_vars, output_vars, mode, type):
	return """float PHI_goldenRati0 = 1.61803398874989484820459 * 00000.1; // Golden Ratio   
float PI_goldenRati0  = 3.14159265358979323846264 * 00000.1; // PI
float SQ2_goldenRati0 = 1.41421356237309504880169 * 10000.0; // Square Root of Two
%s = fract(tan(distance((%s.xy+%s.xy)*(%s+PHI_goldenRati0), vec2(PHI_goldenRati0, PI_goldenRati0)))*SQ2_goldenRati0);""" %[
output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
