shader_type spatial;
render_mode specular_schlick_ggx, cull_back, unshaded;

uniform vec3 ground_rgb : source_color;
uniform vec3 caustics_bw: source_color;
uniform float slowdown : hint_range( 0.1, 10.0, 0.1 ) = 5.0;
uniform float time_caust : hint_range( 0.01, 1.0, 0.01 ) = 0.13;
uniform float tile_caust: hint_range( 0.1, 16.0, 0.1 ) = 4.0;
uniform float tile_ground: hint_range( 0.1, 16.0, 0.1 ) = 8.0;

void fragment() {

// caustics_bw
    vec2 caustics_bw_uv1 = UV * (tile_caust + sin(TIME / slowdown) * time_caust);
	vec2 caustics_bw_uv2 = UV * (tile_caust + cos(TIME / slowdown) * time_caust);
	
	float caustics_bw1_read = caustics_bw.b;
	float caustics_bw2_read = caustics_bw.g;
	
	// ground_rgb
	vec3 ground_rgb_read = ground_rgb;

	ALBEDO = ground_rgb_read.rgb * caustics_bw1_read * caustics_bw2_read;

}