PShader shader;
float mouseWheel = 1;

void setup() {
  size(1000, 1000, P2D);
  noStroke();

  shader = loadShader("fractal.frag");
  shader.set("zoom",mouseWheel);
}

void draw() {
  shader.set("u_resolution", float(width), float(height));
  shader.set("u_mouse", float(mouseX), float(mouseY));
  shader.set("u_time", millis() / 1000.0);
  shader(shader);
  rect(0,0,width,height);
  
}
void mouseWheel(MouseEvent event) {
  mouseWheel += event.getCount() / 2.0;
  shader.set("zoom",mouseWheel);
}