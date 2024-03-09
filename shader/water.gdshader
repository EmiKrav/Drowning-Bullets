shader_type spatial;

uniform vec3 water_color : source_color;
uniform float UV_scale : hint_range(0.0, 10.0, 0.25) = 1.0;
uniform float time_scale : hint_range(0.0, 10.0, 0.25) = 1.0;
uniform sampler2D water_normal_noise;

uniform float normal : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float roughness : hint_range(0.0, 1.0, 0.1) = 0.2;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;
uniform sampler2D sun_highlights;

uniform vec2 abberatiom_r;
uniform vec2 abberatiom_g;
uniform vec2 abberatiom_b;
uniform float highlights_time_scale = 1.0;

vec3 soft_light(vec3 base, vec3 blend){
	vec3 limit = step(0.5, blend);
	return mix(2.0 * base * blend + base * base * (1.0 - 2.0 *blend),
	sqrt(base) * (2.0 * blend - 1.0) + (2.0 * base) * (1.0 - blend), limit);
}

void vertex() {
	// Called for every vertex the material is visible on.
	
}

void fragment() {
	vec2 _UV = UV * UV_scale;
	vec2 _SUV = SCREEN_UV;
	
	_UV.x += sin(TIME * time_scale + (_UV.x + _UV.y) * 25.0) * 0.01;
	_UV.y += cos(TIME * time_scale - (_UV.x + _UV.y) * 25.0) * 0.01;
	
	_SUV.x += sin(TIME * time_scale + (_SUV.x + _SUV.y) * 25.0) * 0.01;
	_SUV.y += cos(TIME * time_scale - (_SUV.x + _SUV.y) * 25.0) * 0.01;
	// Called for every pixel the material is visible on.
	
	float r = texture(sun_highlights, _UV + abberatiom_r + TIME * highlights_time_scale).r;
	float g = texture(sun_highlights, _UV + abberatiom_g + TIME * highlights_time_scale).g;
	float b = texture(sun_highlights, _UV + abberatiom_b + TIME * highlights_time_scale).b;
	
	vec3 blended = soft_light(texture(screen_texture, _SUV).rgb, vec3(r,g,b));
	
	ALBEDO = blended;
	NORMAL_MAP = texture(water_normal_noise, UV).rgb;
	NORMAL *= normal;
	ROUGHNESS = roughness;
	
}

void light() {
	// Called for every pixel for every light affecting the material.
}
