#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float zoom;

const float Max_Iter=400.;

/*float mandelBrot(vec2 uv)
{
    vec2 c=4.*uv-vec2(1.,0.);
    c=c/pow(u_time,2.)-vec2(.744,.11);
    vec2 z=vec2(0.);
    float iter=0.;
    
    for(float i=0.;i<Max_Iter;i++)
    {
        z=vec2(z.x*z.x-z.y*z.y,
        2.*z.x*z.y)+c;
        
        if(dot(z,z)>500.)return iter/Max_Iter;
        iter++;
    }
    
    return iter/Max_Iter;
    
}

vec3 hash13(float m)
{
    float x=fract(sin(m)*5625.246);
    float y=fract(sin(m+2.*x)*2216.486);
    float z=fract(sin(x+2.*y)*88276.352);
    return vec3(x,y,z);
}*/
void main()
{
    vec2 uv=gl_FragCoord.xy/u_resolution;
    uv-=.5;
    uv.x*=u_resolution.x/u_resolution.y;
    vec2 mouse=u_mouse;
    
    uv+=vec2(mouse.x * (zoom * 1.),mouse.y * (  zoom * 1.));
    uv*=(1./ pow(zoom*.2,2.));
    
    
    
    
    vec3 col=vec3(.1686,.1686,.1686);
    vec2 c=vec2(0.);
    
    //MANDEL GOES BRR
    c=4.*uv-vec2(0.,0.);
    
    vec2 z=uv;
    float smoothcolor=exp(-length(uv)*1.);
    for(float i=0.;i<Max_Iter;i++)
    {
        z=vec2(z.x*z.x-z.y*z.y,
        2.*z.x*z.y)+c;
        smoothcolor=.1+.2+.1*(i-log2(log2(dot(z,z))));
        if(dot(z,z)>400.)
        break;
    }
    
    //END OF MANDEL
    col+=smoothcolor;
    float r=.4+.4*(sin(smoothcolor*.1+u_time*.63));
    float g=r*r*.7;
    float b=r*g*10.;
    
    gl_FragColor=vec4(col,1.)*vec4(.0784,.1765,.3255,1.);
    
}