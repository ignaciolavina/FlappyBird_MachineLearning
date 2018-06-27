class Bird{
  
   PImage birdImg;
   PImage crashed_bird_img; 
   int x, y;
   int velocity = 0;
   boolean crashed = false;
   
   float last_mills = millis();
   float delay = 250;
   
   NeuralNetwork nw_net;
  
  public Bird(){   
      birdImg =loadImage("./assets/birdo.png");
      birdImg.resize(50,50);
      crashed_bird_img =loadImage("./assets/crashed_bird.png");
      crashed_bird_img.resize(50,50);
      x = 200;
      y = 200; 
      nw_net = new NeuralNetwork(WIDTH+50, size, 2, 4, 2, 1);
  }
  
    public Bird(int i){   
      birdImg =loadImage("./assets/bird" + i + ".png");
      birdImg.resize(50,50);
      crashed_bird_img =loadImage("./assets/crashed_bird.png");
      crashed_bird_img.resize(50,50);
      x = 200;
      y = 200; 
      nw_net = new NeuralNetwork(WIDTH+50, size, 2, 4, 2, 1);
  }
  
  public void draw(){
    if (crashed){      
      imageMode(CENTER);
      image(crashed_bird_img, x, y);
    }else{
      update();
      imageMode(CENTER);
      image(birdImg, x, y);
    }
           
    if ((millis() - last_mills) > delay){    
      //hace cosas
      last_mills = millis();
      
         float vec [] = new float [2];
         vec[0] =  (pipes[int_nx_pipe].x - bird.x);
         vec[1] =  (pipes[int_nx_pipe].y - bird.y);
         nw_net.set_initial_values(vec);
         final_value = nw_net.get_values();
       if(final_value[0] > 0){
         jump(); 
        }
    } 
  }
  
  public void update(){
      y += velocity;
      velocity ++;
  }
  
  public void jump(){
    velocity = -17;
  }
  
  public void crash(){
    crashed = true;  
  }
  
  public void reset(){
     crashed = false;
     this.y = 200; 
     this.velocity = 0;
  }
  
}
