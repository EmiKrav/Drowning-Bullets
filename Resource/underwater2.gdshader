shader_type spatial;

uniform sampler2D colorramp;

vec2 random(vec2 uv) {
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}

float worley(vec2 uv, float columns, float rows) {
	
	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));
	
	float minimum_dist = 0.8; 
	
	for (int y= -1; y <= 10; y++) {
		for (int x= -1; x <= 10; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);
			
			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);
			minimum_dist = min(minimum_dist, dist);
		}
	}
	
	return minimum_dist;
}

varying vec3 worldposition;

void vertex(){
	worldposition = VERTEX;
}

void fragment(){
	if (worldposition.y < -0.5) {
		float scale = 0.25;
		float worley = worley(worldposition.xz * scale + TIME/10.0 * 0.25f, 3.0f, 3.0f);
		float color = texture(colorramp, vec2(worley)).r;
		color = log(0.999) / log(color);
		color *= 50.0f;
		//EMISSION = vec3(color);
		ALPHA = color;
	}
	else{
		float scale = 0.1;
		float worley = 0.0;
		float color = texture(colorramp, vec2(worley)).r;
		color = min(0.999, color);
		color = log(0.999) / log(color);
		color *= 50.0f;
		//EMISSION = vec3(color);
		ALPHA = color;
	}
}