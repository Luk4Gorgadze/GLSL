#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

const float Max_Iter=500.;

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
    uv*=3.5;
    vec3 col=vec3(0.0, 0.0, 0.0);
    
    //JULIA GOES BRR
    vec2 c=vec2(cos(u_time * 1.),sin(u_time * 1.));
    vec2 z=uv;
    float smoothcolor=0.;
    for(float i=0.;i<Max_Iter;i++)
    {
        z=vec2(z.x*z.x-z.y*z.y,
        2.*z.x*z.y)+c;
        smoothcolor+= fract(exp(-length(z) * 2.)) * 0.2;
        if(dot(z,z)>20.)
        break;
    }
    
    //END OF JULIA
    col+=smoothcolor * vec3(0.2078, 0.5176, 0.9216) * 2.;
    float r=.4+.4*(sin(smoothcolor*.1+u_time*.63));
    float g=r*r*.7;
    float b=r*g*10.;

    gl_FragColor=vec4(col * vec3(0.1059, 0.5333, 0.7333),1.);

    
}