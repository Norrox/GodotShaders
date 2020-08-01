shader_type canvas_item;

vec2 RNGV2(vec2 p) {
	vec3 a = fract(vec3(p.x, p.y, p.x) * vec3(111.11,333.33,444.44));
	a += dot(a, a+33.51);
	return fract(vec2(a.x*a.y, a.y*a.z)); //outputs a random vec2 between 0 and 1
}

void fragment() {
	vec2 uv = UV;
	float m = 0.;
	float t = 121.233 + TIME*.4; //Remove time for a static effect
	float minDist = 100.;
	
	uv *= 3.;
	
	vec2 gv = fract(uv)-0.5;
	vec2 id = floor(uv);
	vec2 ci;
	
	for(float y=-1.; y<=1.; y++){
		for(float x=-1.; x<=1.; x++){
			vec2 offs = vec2(x,y);
			vec2 n = RNGV2(id+offs);
			vec2 p = offs+sin(n*t) * .5;
			float  d = length(gv-p);
			if(d<minDist){
				minDist = d;
			}
		}
	}
	
	vec4 col = vec4(minDist,minDist,minDist, 0.85);
	
	COLOR = vec4(col);
}

