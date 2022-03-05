#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

const float Max_Iter=100.;

void main()
{
    //Properties
    float zoom=0.;
    vec2 c=vec2(0.);
    //Set uo
    vec2 uv=gl_FragCoord.xy/u_resolution;
    uv-=.5;
    uv.x*=u_resolution.x/u_resolution.y;
    
    zoom=1./pow(u_time,clamp(1.+ u_time,0.,2.));
    if(zoom<=.0001)
        zoom=.0001;

    //uv *= 3. * zoom;
    //uv += vec2(.3671,.143899);
    //c=uv + vec2(.0); 

    uv*=3.;
    uv -= vec2(.3671,.143899);
    c=uv + vec2(.0);
    
    vec3 col=vec3(0.1961, 0.2431, 0.9137);
    //MANDEL GOES BRR
    vec2 z=vec2(0.);
    float smoothcolor=exp(-length(uv));
    for(float i=0.;i<Max_Iter;i++)
    {
        z=vec2(z.x*z.x-z.y*z.y,2.*z.x*z.y)+c; // Square
        //z = vec2(pow(z.x,3.) - 3. * z.x * pow(z.y, 2.),3.* pow(z.x, 2.) * z.y - pow(z.y,3.))+c; // Cube
        
        smoothcolor =.1+.1+.15*(i-log2(log2(dot(z,z)/2.)));
        if(dot(z,z)>20.)
        break;
    }
    
    //END OF MANDEL
    col +=smoothcolor;
    float r=.4+.4*(sin(smoothcolor*.4+u_time*.63));
    float g=r*r*.7;
    float b=r*g*10.;
    
    gl_FragColor=vec4(col.xyy,1.)*vec4(0.1608, 0.1569, 0.1569, 1.0);
    
}