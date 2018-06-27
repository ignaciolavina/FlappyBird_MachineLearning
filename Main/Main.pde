/* FLAPPY BIRD GAME
  please, don't be so critical with the graphs, it's just a game! ;)
  ENJOY!
  
  BY Ignacio Laviña (Uco)
*/


PImage bkg_img;
PImage startImg;

static int WIDTH = 800;
//static int HEIGHT = 600;
static int SPACE = 230; //Space inside pipes to pass

int pos_background = 0;
int vel_background = 2;

public enum GameState {WELCOME, GAME, GAMEOVER};  // Different states of the game
GameState game_state = GameState.WELCOME;

Bird bird;
Bird [] birds = new Bird [5];

int score = 0;
int high_score = 0;

int max_pipes = 3;
Pipe [] pipes = new Pipe [max_pipes];
int initial_pipe_x = 600; 

//NEURAL NETWORK STUFF
  static int id_number = 0;
  NeuralNetwork best_nw_net;
  int size = 300;
  PImage nw_bkg_img;
  
  float final_value [] = new float [1];
/*
  float last_mills = millis();
  float delay = 250;
  */
  NeuralNetwork [] nw_nets;
  
void setup() {
  size(1200,600);
  //NEURAL NETWORK SETUP
   best_nw_net = new NeuralNetwork(WIDTH+50, size, 2, 4, 2, 1);
   
   nw_bkg_img = loadImage("./assets/nw_bkg_img.png");
   nw_bkg_img.resize(size + 100, height);
   
   //float vec [] = {2, 5};
   //best_nw_net.set_initial_values(vec);
   //nw_net.get_values();
   
  //FLAPPY BIRD SETUP 
  
  fill(0);
  textSize(40);
  imageMode(CORNER);
  startImg=loadImage("./assets/Start_bkg.png");
  startImg.resize(WIDTH, height);
  bkg_img=loadImage("./assets/background.png");
  bkg_img.resize(WIDTH, height);
  
  bird = new Bird();
  //Pipes creation
  
  for (int i = 0; i<4; i++){
   birds[i]= new Bird(i); 
  }
  
  for (int i = 0; i<max_pipes; i++){
    pipes[i] = new Pipe(initial_pipe_x);
    initial_pipe_x += (WIDTH+40)/max_pipes;
  }
}
int int_nx_pipe = 0;

void draw(){

  switch(game_state){
    case WELCOME:
      imageMode(CORNER);
      image(startImg, 0, 0);
      textSize(15);
      textAlign(CORNER);
      text("Made with love by Uco", WIDTH-200, height-50);
      
      textAlign(CENTER);
      textSize(40);
      text("WELCOME TO UKKI BIRD!", WIDTH/2, height/2 - 50);    
      text("High Score: " + high_score, WIDTH/2, height/2);    
      text("Press ENTER to start ", WIDTH/2, height/2 + 50);

    break;
    case GAME:
      //Background stuff and movement
      imageMode(CORNER);    
      image(bkg_img, pos_background, 0);    
      image(bkg_img, pos_background + bkg_img.width, 0);   
      pos_background -= vel_background;
      if(pos_background <= - bkg_img.width){
        pos_background = 0;
      }
      
      imageMode(CENTER);
      
      //Pipes iteration
      for (int i = 0; i<max_pipes; i++){
        Pipe pipe = pipes[i];
        pipe.draw();
        
        text("int_nx_pipe" + int_nx_pipe, 100, 100);
        //SCORE
        if(bird.x == pipe.x){
          score++;
          int_nx_pipe++;
          if (int_nx_pipe >= max_pipes){
             int_nx_pipe = 0; 
          }
          
        }
        
        //CRASH WITH ROOF OR FLOOR
        if ((bird.y < 0) || (bird.y > WIDTH)){
          restart();
        }
        
        //CRASH WITH PIPES
        if(bird.x >=pipe.x - pipe.pipe_img.width/2 && bird.x <= pipe.x + pipe.pipe_img.width/2){
          if(abs(bird.y - pipes[i].y) > SPACE/2 - bird.birdImg.height/2){            
            bird.crash(); 
            game_state = GameState.GAMEOVER;
          }        
        }
      }//end pipes loop
      bird.draw();
      
      for (int i = 0; i<4; i++){
        birds[i].draw(); 
      }
      
      text("Score: " + score, 130, 50);
     break;
     case GAMEOVER:
      
      text("GAMEOVER", WIDTH/2, height/2 - 50);      
      text("score: " + score, WIDTH/2, height/2);
      text("Press ENTER to restart ", WIDTH/2, height/2 + 50);
     
     break;
  }
     
    //NEURAL NETWORK DRAWING STUFF
    imageMode(CENTER);
    image(nw_bkg_img, WIDTH + 50 + size/2, height/2);
    fill(0);
    //image(bkg_img, 0, 0);
    textSize(20);
    textAlign(CENTER);
    text("NEURONAL NETWORK", WIDTH + 50 + size/2, 100);
    
    
    //neural network display
    stroke(0);
    fill(0);
    best_nw_net.draw();
  //
  
  //INPUTS DISPLAY
    noFill();
    stroke(0);
    strokeWeight(1);
    rect(WIDTH, size + 100, size + 100, 200);
    text("distance x to floor: " + (pipes[int_nx_pipe].x - bird.x), WIDTH + size/2 + 50, size + 200  );
    text("distance y to pipe: " + (pipes[int_nx_pipe].y - bird.y), WIDTH + size/2 + 50, size + 250  );

   /*
  if ((millis() - last_mills) > delay){    
    //hace cosas
    last_mills = millis();
    
       float vec [] = new float [2];
       vec[0] =  (pipes[int_nx_pipe].x - bird.x);
       vec[1] =  (pipes[int_nx_pipe].y - bird.y);
       best_nw_net.set_initial_values(vec);
       final_value = best_nw_net.get_values();
     if(final_value[0] > 0){
       for (int i = 0; i< 4; i++){
         birds[i].jump();
       }
       bird.jump(); 
   }
  } */

  
}
//works upper pipe crash
//if((bird.y <= (pipes[i].y - pipes[i].SPACE/2)) ){

public void restart(){
    println("RESET: " + bird.y);
    int_nx_pipe = 0;
    best_nw_net = new NeuralNetwork(WIDTH+50, size, 2, 4, 2, 1);  
    bird.reset();
    for (int i = 0; i< 4; i++){
     birds[i].reset();
   }
    resetPipes();
    high_score = max(high_score, score);
    score = 0;
    game_state = GameState.WELCOME; 
}

public void resetPipes(){
  initial_pipe_x = 600;
  for (int i = 0; i<max_pipes; i++){
    pipes[i] = new Pipe(initial_pipe_x);
    initial_pipe_x += (WIDTH+40)/max_pipes;
  }
}



void keyPressed(){   
 
    if(key == ENTER){
      restart(); 
      game_state = GameState.GAME;
      if(game_state == GameState.WELCOME){
         
        
      }else{
      }
    }
    
    if(key == ' '){
       bird.jump();
    }  
    if(key == 'r' || key == 'R'){
        restart();    
    }
    /* TEST CODE
    if ( key == CODED){
      switch(keyCode){
       case LEFT:
          break;
       case RIGHT:
          break;
       case UP:
       bird.y -=5;
          break;
       case DOWN:
       bird.y +=5;
          break; 
      }
    }*/
  }
