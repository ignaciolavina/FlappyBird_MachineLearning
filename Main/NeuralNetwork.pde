/* commentar los métodos con código vacío para vídeo */

class NeuralNetwork{
  
  Neuron [] list_initial_layer;
  Neuron [][] list_interm_layer;
  Neuron [] list_final_layer;
  
  ArrayList <Neural_connection> list_conections;
  //Neural_connection [] list_conections;
  
  //int size = 400; //for graphic representation
  int y_space = 0;
  int x_space = 0;
  
  int neurons_interm_layer;
  int neurons_init_layer;
  int num_layers;
  int neurons_final_layer;
  
  public NeuralNetwork(int initial_point, int size, int neurons_init_layer, int neurons_interm_layer, int num_layers, int neurons_final_layer){
    this.neurons_interm_layer = neurons_interm_layer;
    this.neurons_init_layer = neurons_init_layer;
    this.num_layers = num_layers;
    this.neurons_final_layer = neurons_final_layer;
    
    list_initial_layer = new Neuron [neurons_init_layer];
    list_interm_layer = new Neuron [neurons_interm_layer][num_layers];
    list_final_layer  = new Neuron [neurons_final_layer];
    list_conections = new ArrayList<Neural_connection>();
    //list_conections = new Neural_connection [neurons_init_layer*neurons_interm_layer + neurons_interm_layer^num_layers + neurons_final_layer*neurons_interm_layer];
        
    y_space = (size/(neurons_init_layer+1));
    x_space = size/(num_layers + 1);
    
    //creation of first neural layer
    for (int i = 0; i < neurons_init_layer; i++){
       list_initial_layer[i] = new Neuron(initial_point, initial_point + y_space + i*y_space);
    }
    
    //creating second neural layer
    y_space = (size/(neurons_interm_layer+1)); //reset y
    for(int j = 0; j< num_layers; j++){
      for (int i = 0; i < neurons_interm_layer; i++){
        list_interm_layer[i][j] = new Neuron(initial_point + x_space + j*x_space, initial_point + y_space + i*y_space);   
      }
    }
    
    //Creating final output layer
    y_space = (size/(neurons_final_layer+1)); //reset y
    for(int i = 0; i < neurons_final_layer; i++){
       list_final_layer[i] = new Neuron(initial_point + size, initial_point + y_space + i*y_space);
       println("x: " + (initial_point + size) + ", y: " + (initial_point + y_space + i*y_space));
    }
    
    //CONEXIONS!
    //FIRST LAYER
    for (int i = 0; i < neurons_interm_layer; i++){ // i = por cada fila de interm layer
      for(int k = 0; k < neurons_init_layer; k++){ //k = num neurons initial layer
         Neural_connection Neu_con = new Neural_connection(list_initial_layer[k], list_interm_layer[i][0]);
         list_interm_layer[i][0].add_connection(Neu_con);
         list_conections.add(Neu_con); 
      }
    }
    
    //REST OF THE LAYERS
    for (int i = 0; i < neurons_interm_layer; i++){
      for(int j = 1; j < num_layers; j++){
        for(int k = 0; k < neurons_interm_layer; k++){
            //añadir la conexion a la propia neurona
            Neural_connection Neu_con = new Neural_connection(list_interm_layer[k][j-1], list_interm_layer[i][j]);
            list_interm_layer[i][j].add_connection(Neu_con);
            //list_interm_layer[i][j].final_value();
            //añadir conexion a la red general
            list_conections.add(Neu_con); 
        }
      }
    }
    
    //Create final layer conections
    for (int i = 0; i < neurons_interm_layer; i++){
        for(int k = 0; k < neurons_final_layer; k++){
           Neural_connection Neu_con = new Neural_connection(list_interm_layer[i][num_layers-1], list_final_layer[k]);
           list_final_layer[k].add_connection(Neu_con);
           list_conections.add(Neu_con); 
        }      
    } 
  }
  
  public void set_initial_values(float [] init_values){
    for(int i= 0; i< list_initial_layer.length; i++){
      list_initial_layer[i].value = init_values[i];
      //println("valor inicial " + list_initial_layer[i].id + " ," + list_initial_layer[i].value);
    }
  }
  
  // CALCULO DE LOS VALORES DE CADA NEURONA
  public void get_values(){
   for(int j = 0; j < num_layers; j++){
    for (int i = 0; i < neurons_interm_layer; i++){
        list_interm_layer[i][j].final_value();
     }
    }
    
    for (int i = 0; i < neurons_final_layer; i++){
      list_final_layer[i].final_value();
    }
  }
  
  // DRAW FUNCTION
  public void draw(){
    for(int i= 0; i< list_initial_layer.length; i++){
      list_initial_layer[i].draw();       
    }
    
    for(int i= 0; i< list_interm_layer.length; i++){
      for(int j=0; j < list_interm_layer[0].length; j++){  
        list_interm_layer[i][j].draw();
      }
    }
    
    for(int i = 0; i<list_final_layer.length; i++){
       list_final_layer[i].draw();
    }
    
    for (int i=0; i<list_conections.size(); i++){
        list_conections.get(i).draw();
    }
    
  }
  
  public void print_weights(){
    for (int i = 0; i < list_initial_layer.length; i++){
      list_initial_layer[i].draw();       
    }
    
    for(int i= 0; i< list_interm_layer.length; i++){
      for(int j=0; j < list_interm_layer[0].length; j++){  
        list_interm_layer[i][j].draw();
      }
    }
    
    for(int i = 0; i<list_final_layer.length; i++){
       list_final_layer[i].draw();
    }
    
    for (int i=0; i<list_conections.size(); i++){
        list_conections.get(i).draw();
    }
    
    
  }
  
  
  
}
