class Neuron{
  

  String id; //falta completar todo esto
  int x;
  int y;
  int size = 20;
  
  float value;
  float sum;
  
  //ArrayList <Neuron> neurons_prev = new ArrayList <Neuron> ();
  //ArrayList <Neuron> neurons_post = new ArrayList <Neuron> ();
  
  ArrayList <Neural_connection> list_connection_prev = new ArrayList <Neural_connection> ();
  
  //conexiones
  
  public Neuron(int x, int y){
    this.x = x;
    this.y = y;
    //this.id = id + id_number;
    //id_number = id_number ++;
    set_id(id_number);
    //println("neuron: " + id + " x: " + x + ", y: " + y);
    
    /*for (int i=0; i< neurons_prev.size(); i++){
       new Neural_connection(this, neurons_prev.get(i));
    }*/
    
  }
  
  public void draw(){
    fill(0);
    ellipseMode(CENTER);
    ellipse(x, y, size, size);
    textSize(20);
    text(id, x, y);
  }
  
  public void add_connection(Neural_connection neu_con){
    list_connection_prev.add(neu_con);
  }
  
  //para las neuronas iniciales de la red
  public void get_value(float value){
    this.value = value;
  }
  
  //Para el resto, obtiene el valor en funcion de los pesos de las conexiones y el valor anterior
  public float final_value(){    
    sum = 0;
    for (int i = 0; i < list_connection_prev.size(); i++){
      sum += list_connection_prev.get(i).weight*list_connection_prev.get(i).neuron1.value;
      //println("bucl3 " + list_connection_prev.get(i).weight + ", " +list_connection_prev.get(i).neuron1.value + " (id): " + list_connection_prev.get(i).neuron1.id );
    }
    value = sum;
    println("el valor final de la neurona " + this.id + " es: " + value);
    return value;
  }
  
  public void set_id(int id){
    this.id = "N: "+ id;
    id_number ++;
  }
  
}
