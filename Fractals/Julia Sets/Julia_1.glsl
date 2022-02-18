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
    uv *= 2.5;
    vec3 col=vec3(0.1686, 0.1686, 0.1686);
    vec2 c = vec2( 0.37+cos(u_time*1.23462673423)*0.004, sin(u_time*1.43472384234)*0.10+0.01);
	
    //JULIA GOES BRR
   // vec2 c=4.*uv-vec2(1.,0.);
    //c=c/pow(u_time,2.)-vec2(.744,.11);
    vec2 z=uv;
    float iter=0.;
    float smoothcolor=exp(-length(uv));
    for(float i=0.;i<Max_Iter;i++)
    {
        z=vec2(z.x*z.x-z.y*z.y,
        2.*z.x*z.y)+c;
        smoothcolor += exp(-length(z));
        if(length(z)>1.9999)
            break;
    }

    //END OF JULIA
    col+=smoothcolor;
    float r = 0.4+0.4*(sin(smoothcolor*0.1+u_time*0.63));
	float g = r * r * 0.7;
	float b = r * g * 10.;
    
    gl_FragColor=vec4(r,g,b,1.) * vec4(0.502, 0.102, 0.2863, 1.0);
    
}