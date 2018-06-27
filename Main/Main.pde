
  PImage bkg_img;
  static int id_number = 0;
  NeuralNetwork nw_net;
  int size = 400;

void setup(){
 size(800, 600); 
 nw_net = new NeuralNetwork(150, size, 2, 4, 2, 1);   
 bkg_img = loadImage("assets/bkg_img.png");
 
 float vec [] = {2, 5};
 nw_net.set_initial_values(vec);
 nw_net.get_values();
  
}


void draw(){
  fill(0);
  //image(bkg_img, 0, 0);
  textSize(50);
  textAlign(CENTER);
  text("NEURONAL NETWORK", width/2, 100);
  
  //rectangle for display
  noFill();
  stroke(0);
  strokeWeight(1);
  rect(150, 150, size, size);
  
  //neural network display
  fill(0);
  nw_net.draw();
  
  
}
