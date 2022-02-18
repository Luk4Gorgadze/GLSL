
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
float f;

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    st -= 0.5;
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color=vec3(0.9686, 0.3294, 0.3294);

    float r=length(st) * 2.;
    float a=atan(st.y,st.x);
    float f=cos((a - u_time ) * 3. );
    //f = abs(cos(a*10. * cos(abs(u_time) / 4.)));
    //f = abs(cos(a*3. * cos(abs(u_time) / 4.)));
     //f = abs(cos((a- u_time)*12.)*sin((a- u_time * 2.)*3.))*.8+.1;
     f = smoothstep(-.5,1., cos((a- u_time)*10.))*0.2+0.5;
    
    color = vec3(1.-smoothstep(f,f+0.02,r)) + color;
    //color=vec3(smoothstep(f,f+.02,r));
    
    gl_FragColor=vec4(color,1.);
}
