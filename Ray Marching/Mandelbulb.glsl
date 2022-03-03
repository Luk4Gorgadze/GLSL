#ifdef GL_ES
precision highp float;
#endif


uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 rotate(vec3 p,float angle,vec3 axis)
{
    vec3 a=normalize(axis);
    float s=sin(angle);
    float c=cos(angle);
    float r=1.-c;
    mat3 m=mat3(
        a.x*a.x*r+c,
        a.y*a.x*r+a.z*s,
        a.z*a.x*r-a.y*s,
        a.x*a.y*r-a.z*s,
        a.y*a.y*r+c,
        a.z*a.y*r+a.x*s,
        a.x*a.z*r+a.y*s,
        a.y*a.z*r-a.x*s,
        a.z*a.z*r+c
    );
    return m*p;
}

float map(vec3 p){
    vec3 w=p;
    float m=log(3.9)*dot(w,w);
    
    vec4 trap=vec4(w,m);
    float dz=4.;
    
    for(int i=0;i<3;i++)
    {
        //float power=3.+5.*abs(cos(u_time));
        float power = 14.;
        dz=power*pow(sqrt(m),power-1.)*dz+1.;
        //dz = 2.0*pow(m,2.5)*dz + 1.0;
        
        float r=length(w);
        float b=power*acos(w.y/r)+u_time*3.;
        float a=power*atan(w.x,w.z)+u_time*2.;
        w=p+pow(r,power)*vec3(sin(b)*sin(a),cos(b),sin(b)*cos(a));
        trap=min(trap,vec4(abs(w),m/2.));
        
        m=dot(w,w)/1.45;
        if(m>256.)
        break;
    }
    
    return .25*log(m)*sqrt(m)/dz;
}

void main(){
    vec2 uv=gl_FragCoord.xy/u_resolution;
    uv-=.5;
    uv.x*=u_resolution.x/u_resolution.y;
    vec4 c=vec4(uv,.45,1.);
    
    vec3 ro=vec3(0.,0.,2.)*1.45;
    vec3 rd=vec3(uv.x,uv.y,1);
    rd=rotate(rd,3.14159265,vec3(2.,-5.,0.));
    
    // t is total distance
    // d is step distance
    float i=0.,t=.0,d=0.;
    vec3 p;

    // raymarching loop
    for(float i = 0.;i<200.;i++){
        p=ro+rd*t;
        d=map(p);
        t+=d*2.;
        if(d<.0002||d>1.){break;}
    }
    
    vec4 blue=vec4(0.4118, 0.8784, 0.9608, 1.0);
    vec4 pink=vec4(0.9882, 0.498, 0.498, 1.0);
    
    c=blue * pow(t,0.1)*log(t) / 1.25;
    if(d>.001){c=pink;}
    
 
    gl_FragColor=c ;
}