
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution;
    float pct=0.;
    
    // a. The DISTANCE from the pixel to the center
    pct=distance(st,vec2(.5))*2.;
    //pct=distance(st,vec2(.4))+distance(st,vec2(.6));
    //pct=distance(st,vec2(.2))*distance(st,vec2(.6) * 2.5);
    float pc = abs(sin(u_time));
    float a = min(distance(st,vec2(.2,.3) * pc),distance(st,vec2(.8,.3) * pc));
    float b = min(distance(st,vec2(.2,.7) * pc),distance(st,vec2(.8, .7) * pc));
    pct=min(a,b) * 6.;
    //pct=max(distance(st,vec2(.4)),distance(st,vec2(.6))) * 6.;
    //pct=pow(distance(st,vec2(.4)),distance(st,vec2(.6)) * 6.);
    
    // b. The LENGTH of the vector
    //    from the pixel to the center
    // vec2 toCenter = vec2(0.5)-st;
    // pct = length(toCenter);
    
    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
    // vec2 tC = vec2(0.5)-st;
    // pct = sqrt(tC.x*tC.x+tC.y*tC.y);
    
    float color=smoothstep(.49,.51,1.-pct);
    //vec3 color = vec3(1.0-pct);
    
    gl_FragColor=vec4(vec3(0.5608, 1.0, 0.7059)*color + vec3(0.3176, 0.6588, 0.8863),1.);
}
