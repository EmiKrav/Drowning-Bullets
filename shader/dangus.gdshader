shader_type sky;

uniform vec3 skycolor : source_color;
uniform vec3 horizoncolor : source_color;
uniform sampler2D skytexture;

void sky() {
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
	
	float col = clamp(EYEDIR.y / 0.05, 0.0, 1.0);
	vec3 finalColor = mix(horizoncolor, skycolor, col);
	COLOR = texture(skytexture, vec2(SKY_COORDS.x + TIME / 1000.0, SKY_COORDS.y)).rgb;
	
}
