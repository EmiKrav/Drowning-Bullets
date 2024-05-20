shader_type spatial;

uniform sampler2D noise;

varying vec3 worldposition;

void vertex(){
	worldposition = VERTEX;
}

void fragment(){
	if (worldposition.y < -0.5) {
		float scale = 0.4;
		float color = texture(noise, worldposition.xz * scale + TIME * 0.008).x;
		color = log(0.999) / log(color);
		color *= 25.0f;
		EMISSION = vec3(color);
		ALPHA = color;
	}
	else{
		float scale = 1.0;
		float worley = 0.0;
		float color = texture(noise, vec2(worley)).r;
		color = min(0.999, color);
		color = log(0.999) / log(color);
		color *= 50.0f;
		//EMISSION = vec3(color);
		ALPHA = color;
	}
}