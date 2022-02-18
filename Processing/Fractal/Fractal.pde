PShader shader;
float mouseWheel = 1;
float mX;
float mY;


void setup() {
    size(1000, 1000, P2D);
    noStroke();
    
    shader = loadShader("Fractal2.glsl");
    //hader.set("zoom",mouseWheel);
}

void draw() {
    shader.set("u_resolution", float(width), float(height));
    mX = (mouseX / float(width) * 2.0 - 1.0) * 0.5;
    mY = (mouseY / float(height) * 2.0 - 1.0) * 0.5;
    println("X : " + mX);
    println("Y : " + mY);
    shader.set("u_mouse", -mX,mY);
    
    
    shader.set("u_time", millis() / 1000.0);
    shader(shader);
    rect(0,0,width,height);
    
}
void mouseWheel(MouseEvent event) {
    mouseWheel += event.getCount() / 2.0;
    shader.set("zoom",mouseWheel);
}