/*
Elaborado por Martha Daniela Maldonado. Composición aplicando FOR.
*/

PImage cab, cuer;
float ang;
int rapPX, rapPY;
int dir=1, dirCola1=1,dirCola2=1,dirCola3=1, dirPX=1, dirPY=1;
int posXB=300;
int posYB=400;
int cogePelota=0;
int rebotaPelota=0;
float colaX[] ={110,95,75,60,140,160,180};
float colaY[] ={270,240,210,180,200,240,270};
float av1,av2,av3;

void setup(){
  size(800,500);
  //Carga la imagen del perrito
  cab = loadImage("Cabeza.png");
  cuer = loadImage("Cuerpo.png");
}

void draw(){
  background(82,190,255);
 //PISO....................................................................
 fill(146,224,32);
 ellipse(100,posYB-40,1000,600);
 ellipse(600,350,800,600);
 
 //Huellitas usando FOR !!!
 for(int h=0;h<=800;h+=60){
   for(int i=120;i<=500;i+=60){
     fill(0,0,0,30);
     ellipse(h,i,30,20);
     ellipse(h-15,i+12,12,12);
     ellipse(h,i+18,12,12);
     ellipse(h+15,i+14,12,12);
   }
 }
 
 //COLA................................................................

//Si el usuario coge la pelota, el perro mueve la cola
 if(cogePelota==1){
  stroke(0);
  strokeWeight(3);
  fill(255);
  
  //Condicionales que determinan según la posición del vector con el que se hizo la cola, la dirección a la que debe ir
  if((colaX[1]+av1)<105 || ((colaX[1]+av1)> 150 )){
  dirCola1=dirCola1*(-1); 
  }
  if((colaX[2]+av2)<85 || ((colaX[2]+av2)> 200 )){
  dirCola2=dirCola2*(-1); 
  }
  if((colaX[3]+av3)>280 || ((colaX[3]+av3)< 60 )){
  dirCola3=dirCola3*(-1); 
  }
  
  //Determina el avance de cada par de vectores
  av1=2;
  av2=4.2;
  av3=8;
  
  //Posición de los vectores según el avance y la dirección establecida
  colaX[1]=colaX[1]+av1*dirCola3;
  colaX[2]=colaX[2]+av2*dirCola3;
  colaX[3]=colaX[3]+av3*dirCola3;
  colaX[4]=colaX[4]+av2*dirCola3;
  colaX[5]=colaX[5]+av1*dirCola3;
  
  //Dibuja la cola por vectores
  beginShape();
  vertex(colaX[0], colaY[0]);
  vertex(colaX[1], colaY[1]);
  vertex(colaX[2], colaY[2]);
  vertex(colaX[3], colaY[3]);
  vertex(colaX[4], colaY[4]);
  vertex(colaX[5], colaY[5]);
  vertex(colaX[6], colaY[6]);
  endShape(CLOSE);
  }
  else{ //Si no coge la bola, la cola permanece quieta
  stroke(0);
  strokeWeight(3);
  fill(255);
  beginShape();
  //Uso del FOR!!!
    for(int i=0; i<7; i++){
       vertex(colaX[i], colaY[i]);
    }
  endShape(CLOSE); 
  }
  
  
  //CUERPO ..................................................................................
  //Dibuja la imagen y la modifica según el centro
  imageMode(CENTER);
  //Posiciona y elige el tamaño de la imagen del cuerpo
  image(cuer, 150,290,250,200);
 
  
  //CABEZA.................................................................................
  //Si no ha cogido el usuario la pelota, el perrito mueve la cabeza, de lo contrario la deja fija
  if(cogePelota==0 ){
  //Aplica los cambios de traslado y rotación a lo que esté dentro de push y popMatrix
  pushMatrix();
  
  //Traslada la cabeza para que se pueda palicar rotación
  translate(160,155);
  
  // Cambia la dirección de la cabeza según el ángulo de giro
  if(ang <(-PI/8) || ang> PI/8){
  dir=dir*(-1);
  }
  
  //Aumenta o disminuye el ángulo de gira en avance de 0.001 rad
  ang=ang+(dir*0.005);
  rotate(ang);
  
  //Posiciona y elige el tamaño de la imagen de la cabeza
  image(cab,0,0,170,180);
  popMatrix(); //Termina traslado y rotación
  }
  else{
  //Posiciona y elige el tamaño de la imagen de la cabeza
  image(cab,160,155,170,180); 
  }
    
  //PELOTA....................................................................................
  //Si el usuario pasa el mouse por la pelota para jugarle al perro, se activa la variable 'cogePelota'
  if((mouseX<(posXB+15) && mouseX>(posXB-15)) && ((mouseY<posYB+15) && (mouseY>posYB-15))){
  cogePelota=1;
  }
  
  //Si coge la pelota, esta sigue el mouse, de lo contrario, se queda en una posición fija
  if(cogePelota==1 && rebotaPelota==0){
  //Dibuja la pelota y su posición es según el mouse
  fill(96,36,180);
 noStroke();
  ellipse(mouseX,mouseY,30,30);
  noStroke();
  fill(143,87,222);
  //Sombras de la pelota
  ellipse(mouseX-9,mouseY,10,20);
  ellipse(mouseX+10,mouseY,10,20);
  
    //Si da click se activa una variable que autoriza que rebote la pelota y guarda la posición del mouse en es momento
    if (mousePressed){
     rebotaPelota=1; 
     rapPX=mouseX;
     rapPY=mouseY;
    }
  }
  
  //Estado inicial cuando no ha cogido la pelota
  if(cogePelota==0 && rebotaPelota==0){
  //Dibuja la pelota y su posición es fija
  fill(96,36,180);
  noStroke();
  ellipse(posXB,posYB,30,30);
  noStroke();
  fill(143,87,222);
  //Sombras de la pelota
  ellipse(posXB-9,posYB,10,20);
  ellipse(posXB+10,posYB,10,20); 
  }
  
  
  //Si se autoriza que rebote la pelota
  if(rebotaPelota==1){
    
    //Cuadra la posición según avance y dirección
    rapPX=rapPX+(dirPX*15);
    rapPY=rapPY+(dirPY*8);
    
    //Condiciona el cambio de dirección cuando llega a los límites
    if (rapPX>800 || rapPX<posXB){
      dirPX=dirPX*(-1);
    }
    if (rapPY>500 || rapPY<0){
      dirPY=dirPY*(-1);
    }
    
  
    //Dibuja la pelota y su posición es según el la posición de rebote
    fill(96,36,180);
    noStroke();
    ellipse(rapPX,rapPY,30,30);
    noStroke();
    fill(143,87,222);
    //Sombras de la pelota
    ellipse(rapPX-9,rapPY,10,20);
    ellipse(rapPX+10,rapPY,10,20);
    
  }
  
  
  
  

 
  
  
  


  
}
