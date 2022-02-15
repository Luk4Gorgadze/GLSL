
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    vec3 color=vec3(0.);
    vec2 pos=-st+vec2(.5);
    float r=length(pos)*2.;
    float a=atan(pos.y,pos.x);
    float f=cos(a*5.);
    // f = abs(cos(a*3.));
    //f = abs(cos(a*1.5))*.5+.3;
     f = abs(cos(a*12.)*sin(a*3.))*.8+.1;
    // f = smoothstep(-.5,1., cos(a*10.))*0.2+0.5;
    
    color=vec3(1.-smoothstep(f,f+.02,r));
    
    gl_FragColor=vec4(color,1.);
}
