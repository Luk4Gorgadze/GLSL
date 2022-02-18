#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 7.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Reference to
// http://thndl.com/square-shaped-shaders.html

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st -= 0.5;
  st.x *= u_resolution.x/u_resolution.y;
  vec3 color = vec3(0.8118, 0.3529, 0.3529);
  float d = 0.0;

  // Remap the space to -1. to 1.
  st = st * 2.;

  // Number of sides of your shape
  int N = 8;

  // Angle and radius from the current pixel
  float a = atan(st.x,st.y)+u_time;
  float r = TWO_PI/float(N);

  // Shaping function that modulate the distance
  d = cos(floor(.5+a/r)*r-a)*length(st);

  color = vec3(1.0-smoothstep(.4,.41,d)) + vec3(0.3373, 0.7294, 0.9529);
  // color = vec3(d);

  gl_FragColor = vec4(color,1.0);
}