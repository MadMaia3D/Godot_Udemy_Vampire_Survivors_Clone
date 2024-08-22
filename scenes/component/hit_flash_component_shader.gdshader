shader_type canvas_item;

uniform float lerp_percent: hint_range(0.0f, 1.0f) = 0.0f;

void fragment() {
	vec4 textColor = texture(TEXTURE, UV);
	vec4 finalColor = mix(textColor, vec4(1.0f, 1.0f, 1.0f, textColor.a), lerp_percent);
	COLOR = finalColor;
}
