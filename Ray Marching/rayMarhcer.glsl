#ifdef GL_ES
precision highp float;
#endif
#define MAX_STEPS 100
#define MAX_DIST 100.
#define SURF_DIST.01

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float GetDist(vec3 p)
{
    vec4 s=vec4(0.,1.2,6.,1.);
    vec4 ss=vec4(0,1.2,6.,.1);
    ss.xz=s.xz+vec2(2.*sin(u_time),2.*cos(u_time));
    float sphereDist=length(p-s.xyz)-s.w;
    float sphereDist2=length(p-ss.xyz)-ss.w;
    float planeDist=p.y;
    float d=min(sphereDist2,min(sphereDist,planeDist));
    return d;
}
vec3 GetNormal(vec3 p)
{
    float d=GetDist(p);
    vec2 e=vec2(.0001,0.);
    
    vec3 n=d-vec3(
        GetDist(p-e.xyy),
        GetDist(p-e.yxy),
        GetDist(p-e.yyx));
        
        return 1.*normalize(n);
    }
    float raymarch(vec3 ro,vec3 rd)
    {
        float dO=0.;
        for(int i=0;i<MAX_STEPS;i++)
        {
            vec3 p=ro+rd*dO;
            float dS=GetDist(p);
            dO+=dS;
            if(dO>MAX_DIST||dS<SURF_DIST)break;
        }
        return dO;
    }
    float getLight(vec3 p)
    {
        vec3 lightPos=vec3(0.,5.,3.);
        lightPos.xz+=vec2(2.*sin(u_time),2.*cos(u_time));
        vec3 l=normalize(lightPos-p);
        vec3 n=GetNormal(p);
        
        float dif=clamp(dot(n,l),0.,1.);
        
        float d=raymarch(p+n*SURF_DIST*1.03,l);
        if(d<length(lightPos-p))dif*=.5;
        return dif;
    }
    
    void main()
    {
        vec2 uv=gl_FragCoord.xy/u_resolution;
        uv-=.5;
        uv.x*=u_resolution.x/u_resolution.y;
        vec3 col=vec3(0);
        
        vec3 cam=vec3(0.,1.,0.);
        vec3 rd=normalize(vec3(uv.x,uv.y,1.));
        float d=raymarch(cam,rd);
        
        vec3 p=cam+rd*d;
        float dif=getLight(p);
        
        col=vec3(dif)+vec3(.1569,.0039,.2196);
        //col = GetNormal(p);
        gl_FragColor=vec4(col,1.);
        
    }