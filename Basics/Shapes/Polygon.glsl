#ifdef GL_ES
precision mediump float;
#endif

const float PI=3.1415926535;
uniform vec2 u_resolution;

float polygonShape(vec2 position,float radius,float sides)
{
  position=(position);
  float angle=atan(position.x,position.y);
  float slice=PI*2./sides;
  return step(radius,cos(floor(.5+angle/slice)*slice-angle)*length(position));
  
}

void main(){
  vec2 position=gl_FragCoord.xy/u_resolution;
  position.x*=u_resolution.x/u_resolution.y;
  position-=.5;
  position*=2.;
  float polygon=polygonShape(position,.6,20.);
  vec3 color=vec3(polygon);
  gl_FragColor=vec4(color,1);
}
