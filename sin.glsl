#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(float y, float pct) {
    float w = 0.02;
    return smoothstep(pct-w/2.0, pct, y) - smoothstep(pct, pct+w/2.0, y);
}

void main() {        
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    // map x axis [0.0, 1.0] to [0.0, 2*pi] to include a full sin wave
    // and add u_time to animate.
    float y = sin(st.x * 3.14159 * 2.0 + u_time);
    // resize wave by half half and make it center
    float pct = plot(st.y, y*0.25+0.5);
	vec3 color = vec3(0.0);
	color = (1.0-pct)*color+(pct)*vec3(0.0, 1.0, 0.0);
    gl_FragColor = vec4(color, 1.0);
}
