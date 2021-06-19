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

float inside_rect(vec2 st) {
    vec2 ro = vec2(0.4);
    vec2 dm = vec2(0.2);
    return (step(ro.x, st.x) - step(ro.x+dm.x, st.x)) * (step(ro.y, st.y) - step(ro.y+dm.y, st.y));
}

void main() {        
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    // get line
    float y = abs(sin(u_time * 2.0));
    // draw rectangle and show only if its position is above line
    float pct = step(y, st.y) * inside_rect(st);
    // mix rectangle and line
    pct += plot(st.y, y);    
    vec3 color = vec3(0.0);
    color = (1.0-pct)*color+(pct)*vec3(0.0, 1.0, 0.0);
    gl_FragColor = vec4(color, 1.0);
}
