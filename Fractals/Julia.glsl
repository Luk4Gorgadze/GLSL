#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

const float Max_Iter = 1000.0;


float mandelBrot(vec2 uv)
{
    vec2 m = u_mouse.xy / u_resolution.xy;
    m -= .5;
    float zoom = pow(3., 0. * 20.);
    float shifter = 2.;abs(3. * sin(cos(u_time)));
    vec2 c =  uv * zoom * 2. + m * zoom;
    //c += vec2(-.69955, .37999);
    //c += vec2(-.49955, .6025);
    //c += vec2(m.x,m.y);
    //c += vec2(-.5);
    
    c = c / pow(u_time, 2.) - vec2(0.770,0.10);
    //z_1 = z_0^2 + c
    vec2 z = vec2(0.0);
    float iter = 0.0;
    for(float i = 0.; i < Max_Iter; i++)
    {
        z = vec2(z.x * z.x - z.y * z.y,
                shifter * z.x * z.y) + c;

        if(dot(z,z) > 10.0) return iter/Max_Iter;
        iter++;
    }

    return iter/Max_Iter;

}

vec3 hash13(float m)
{
    float x = fract(cos(m) * 5625.246 );
    float y = fract(sin(x + 200.) * 2216.486);
    float z = fract(sin(y + 20.) * 88276.352);
    return vec3(x,y,z);
}
void main()
{
    vec2 uv = gl_FragCoord.xy/u_resolution;
    uv -= .5;
    uv.x *= u_resolution.x/ u_resolution.y;
    vec3 col = vec3(0.0, 0.0, 0.0);
    float m =  mandelBrot(uv);
    //col = vec3(m);//hash13(m);
    //col += pow(10. * m * vec3(1.0, 1.0, 1.0), vec3(1.)) + vec3(0.1294, 0.149, 0.3333);
    col += 2. * m + vec3(0.4824, 0.6667, 0.8784);
    gl_FragColor = vec4(col,1.);
    // + vec3(0.0549, 0.0196, 0.2)
    
}