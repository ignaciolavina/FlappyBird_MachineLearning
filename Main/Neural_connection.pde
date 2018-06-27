class Neural_connection{
 
  float weight;
  //int ponderation;
  Neuron neuron1, neuron2;
  String id;
  
  public Neural_connection(Neuron neuron1, Neuron neuron2){
    this.neuron1 = neuron1;
    this.neuron2 = neuron2;
    this.weight = random(-1, 1);
    this.id = "Conn id: " + neuron1.id + "|" + neuron2.id;
    //println(id);
  }
  
  public void draw(){
   if(weight < 0){
      stroke(0);
      strokeWeight(abs(1+weight*4));      
      line(neuron1.x, neuron1.y, neuron2.x, neuron2.y); 
     
   }else{
     stroke(255);
     strokeWeight(1+weight*4);
     line(neuron1.x, neuron1.y, neuron2.x, neuron2.y); 
   }
  }
  
  
}
