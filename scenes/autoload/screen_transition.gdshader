shader_type canvas_item;

uniform vec4 color: source_color;
uniform sampler2D transition_texture: hint_default_black, filter_nearest;
uniform float percentage: hint_range(0.0, 1.0) = 0.0f;

void fragment() {
	COLOR = color;
	float tex_intensity = texture(transition_texture, UV).r;
	bool transparency = tex_intensity < percentage;
	COLOR.a = float(transparency);
}
