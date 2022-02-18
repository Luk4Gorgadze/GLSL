#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
	vec2 mousePos = u_mouse.xy / u_resolution;
	gl_FragColor = vec4(mousePos.x,mousePos.y,abs(sin(u_time)),1.0);
}