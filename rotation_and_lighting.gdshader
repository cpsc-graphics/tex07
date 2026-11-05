shader_type spatial;

// diffuse_lambert render mode will allow us to do phong shading
render_mode diffuse_lambert;


// uniforms that can be constrolled from the Inspector panel
uniform vec3 color_a : source_color = vec3(0.7, 0.6, 0.5);
uniform float rotation_speed : hint_range(-10.0, 10.0) = 2.0;
uniform float shininess : hint_range(0.0, 128.0) = 60.0;
uniform float k_d : hint_range(0.0, 1.0) = 0.5;
uniform float k_s : hint_range(0.0, 1.0) = 0.5;

uniform sampler2D noise_texture : hint_default_white, filter_linear;
uniform float m : hint_range(1.0, 100.0) = 24.0;

float get_noise(vec2 uv) {
    return texture(noise_texture, uv).r;
}

float turbulence(vec2 uv) {
    float t = 0.0;
    float denom = 1.0;
    for (int i = 0; i <= 4; i++) {
        float factor = float(1 << i);
        t += get_noise(uv * factor) / denom;
        denom *= 2.0;
    }
    return t;
}


mat4 buildRMatrixY( float current_angle ) {
	float cos_a = cos(current_angle);
    float sin_a = sin(current_angle);
    
    // Build the 3D rotation matrix for the Y-axis
    mat4 rotation_matrix = mat4(
        vec4(cos_a,  0.0, -sin_a, 0.0),
        vec4(0.0,    1.0,  0.0, 0.0),
        vec4(sin_a,  0.0,  cos_a, 0.0), 
		vec4(0.0, 0.0, 0.0, 1.0)
    );
	
	return rotation_matrix;	
}

void vertex() {
	float current_angle = TIME * rotation_speed;
	
	// Call buildRMatrix and use it to transform
	// the built-ins VERTEX and NORMAL

	mat4 R = buildRMatrixY(current_angle);
	VERTEX = mat3(R) * VERTEX;
	NORMAL = mat3(R) * NORMAL;
}

void fragment() {
    vec2 uv = UV;
    float t = turbulence(uv);
    float s = 0.5 * (1.0 + sin(m * 3.14159265359 * (uv.x + uv.y + t)));
	ALBEDO = k_d * color_a * s;
}

void light() {
    // --- Phong shading without ambient ---
    float dot_nl = max(dot(NORMAL, LIGHT), 0.0);
    vec3 diffuse = ALBEDO * LIGHT_COLOR * dot_nl;    
    DIFFUSE_LIGHT += diffuse;
	
    // Calculate specular lighting
    // store the result in the built-in SPECULAR_LIGHT
	
	SPECULAR_LIGHT = k_s * LIGHT_COLOR * pow(max(dot(VIEW, reflect( -LIGHT, NORMAL )), 0.0), shininess);
	
}
