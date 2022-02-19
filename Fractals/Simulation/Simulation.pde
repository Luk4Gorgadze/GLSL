PShader shader;


void setup() {
    size(1000, 1000, P2D);
    noStroke();
    
    shader = loadShader("Julia_4_Powers_2.glsl");
    //hader.set("zoom",mouseWheel);
}

void draw() {
    shader.set("u_resolution", float(width), float(height));    
    shader.set("u_time", millis() / 1000.0);
    shader(shader);
    rect(0,0,width,height);

    //saveFrame("outJulia4/filename-####.png");
    
}
