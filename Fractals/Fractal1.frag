#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

const float Max_Iter = 200.0;

float mandelBrot(vec2 uv)
{
    vec2 c = 4. * uv - vec2(1.,0.0);
    c = c / pow(u_time, 2.) - vec2(0.744,0.11);
    vec2 z = vec2(0.0);
    float iter = 0.0;
    for(float i = 0.; i < Max_Iter; i++)
    {
        z = vec2(z.x * z.x - z.y * z.y,
                2. * z.x * z.y) + c;

        if(dot(z,z) > 500.0) return iter / Max_Iter;
        iter++;
    }

   return iter/Max_Iter;

}

vec3 hash13(float m)
{
    float x = fract(sin(m) * 5625.246 );
    float y = fract(sin(m + 2.*x) * 2216.486);
    float z = fract(sin(x + 2.*y) * 88276.352);
    return vec3(x,y,z);
}
void main()
{
    vec2 uv = gl_FragCoord.xy/u_resolution;
    uv -= .5;
    uv.x *= u_resolution.x/u_resolution.y;
    vec3 col = vec3(0.0, 0.0, 0.0);
    float m = mandelBrot(uv);
    col += m;//hash13(m);
    col = pow(col, vec3(.45)) + vec3(0.4824, 0.6667, 0.8784)/8.;
 
    gl_FragColor = vec4(col,1.);
    // + vec3(0.0549, 0.0196, 0.2)
    
}