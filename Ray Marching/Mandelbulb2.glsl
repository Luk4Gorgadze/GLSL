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
        a.x*a.z*r+a.x*s,
        a.y*a.z*r-a.x*s,
        a.z*a.z*r+c
    );
    return m*p;
}

float map(vec3 p){
    vec3 w=p;
    float m=log(3.9)*dot(w,w);
    
    vec4 trap=vec4(w,m);
    float dz=5.;
    
    for(int i=0;i<5;i++)
    {
        //float power=3.+5.*abs(cos(u_time));
        float power=11.;
        dz=power*pow(sqrt(m),power-1.)*dz+1.;
        //dz = 2.0*pow(m,2.5)*dz + 1.0;
        
        float r=length(w);
        float b=power*acos(w.y/r)+1.2-u_time*2.;
        float a=power*atan(w.x,w.z)+u_time*2.;
        w=p+pow(r,power)*vec3(sin(b)*sin(a),cos(b),sin(b)*cos(a));
        trap=min(trap,vec4(abs(w),m/2.));
        
        m=dot(w,w)/1.45;
        if(m>256.)
        break;
    }
    
    return.25*log(m)*sqrt(m)/dz;
}

void main(){
    vec2 uv=gl_FragCoord.xy/u_resolution;
    uv-=.5;
    uv.x*=u_resolution.x/u_resolution.y;
    vec4 c=vec4(uv,.45,1.);
    
    vec3 ro=vec3(0.,0.,2.)*1.3;
    vec3 rd=vec3(uv.x,uv.y,1.);
    rd=rotate(rd,3.14159265,vec3(0.,u_time,0.));
    
    // t is total distance
    // d is step distance
    float i=0.,t=.0,d=0.;
    vec3 p;
    
    // raymarching loop
    for(float i=0.;i<300.;i++){
        p=ro+rd*t;
        d=map(p);

        if(d<.00001||d>10.2){break;}
        t+=d*1.149;
    }
    
    vec4 blue=vec4(.4118,.8784,.9608,1.);
    vec4 pink=vec4(0.9333, 0.4667, 0.4667, 1.0);
    
    c=blue*pow(t,.002)*log(t)/1.25 * t *1.4;
    if(d >= 0.001 && d < .02) c = 1.*vec4(0.1176, 0.5098, 0.6941, 1.0);
    if(d>.2){c=pink;}
    if(t < 2.5)c *= vec4(0.2235, 0.5451, 0.9686, 1.0) / 2.;
    if(t < 1.78)c *= vec4(0.0314, 0.0314, 0.5255, 1.0) / 2.;
    gl_FragColor=c;
}