class Pipe{
  
  PImage pipe_img;
  int x, y;
  int VEL = 4;
  
  public Pipe(int x){
    pipe_img =loadImage("assets/pipe.png");
    this.x = x;
    y = (int) random(200, height-200);
  }
  
  public void draw(){
      imageMode(CENTER);
      image(pipe_img, x, y - (pipe_img.height/2+SPACE/2));
      image(pipe_img, x, y + (pipe_img.height/2+SPACE/2));
       update();
       
       fill(0);
       ellipse(x, y, 5, 5);
  }
  
  public void update(){
    x -= VEL;
    if(x < -40){
        x = WIDTH;
        y = (int) random(200, height-200);
    }
  }

}
