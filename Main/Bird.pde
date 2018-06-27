class Bird{
  
   PImage birdImg;
   PImage crashed_bird_img; 
   int x, y;
   int velocity = 0;
   boolean crashed = false;
  
  public Bird(){   
      birdImg =loadImage("./assets/birdo.png");
      birdImg.resize(50,50);
      crashed_bird_img =loadImage("./assets/crashed_bird.png");
      crashed_bird_img.resize(50,50);
      x = 200;
      y = 200; 
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
