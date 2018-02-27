class Letra{
  //de mi objeto letra quiero almacenar su posición y la letra que es
  int x,y;
  char c;
  //esta variaable registra el tiempo para las animaciones
  float delta = PI;
  //almacena el ancho del caracter
  float ancho;
  //el color aleatorio del caracter grande
  color salto;
  
  Letra(){
  }
  
  //este metodo establece el valor del c, su ancho y el color de la animación
  void setFont(char c_){
    c = c_;
    textFont(fuente);
    ancho = textWidth(c);
    salto = color (random(255),random(255),random(255));
  }
  
  //establece la posición del caracter
  void reset(int x_, int y_){
    x = x_;
    y = y_;
  }

  //muestra el caracter al finalizar la animación
  void display1(){
    if (delta>=PI){
    fill(bloque);
    textFont(fuente);
    textAlign(LEFT);
    text(c,x,y);
    }
  }
  
  //muestra la animación
  void display2(){
    if(delta<PI){
      delta+=0.07;
      float f = sin(delta);
      pushMatrix();
      translate(x,y);
      float px = width/2 -x;
      float py = height*0.8 - y;
      translate(map(f,0,1,0 + ancho/2,px),map(f,0,1,0,py));
      fill(salto);
      textFont(grande);
      textSize(100 + f*600);
      // si es un espacio es un random
      if ( c == ' '){
        textAlign(CENTER);
        text(char(round(random(33,126))),0,0);
      }
      //si no es el caracter
      else {
        textAlign(CENTER);
        text(c,0,0);
      }
      popMatrix();
    }
  }
}

PFont fuente;
PFont grande;
ArrayList <Letra>texto;
int arraySize;
int indice;
color fondo;
color bloque;
int numeroLineas;
int arriba;
int izquierda;
int derecha;
int interlineado;
int abajo;
int px;
int py;
int cuenta;
int cambioColor;

void setup(){
  size(800,600);
  arraySize = 400;
  indice = 0;
  numeroLineas = 6;
  arriba = 90;
  izquierda = 40;
  derecha = width - izquierda;
  interlineado = 90;
  abajo = interlineado*numeroLineas;
  px = izquierda;
  py = arriba;
  cuenta = 0;
  cambioColor =1;
  fuente = createFont("Futura",100);
  grande = createFont("Futura",600);
  texto = new ArrayList<Letra>();
  textFont(fuente);
  for (int i =0; i<arraySize; i++){
    texto.add(new Letra());
  }
  fondo = color (random(255),random(255),random(255));
  bloque = color (random(255),random(255),random(255));
  frameRate(30);
  noSmooth();
}

void draw(){
  background(fondo);
  for(Letra l:texto){
    if(l.y<=interlineado*numeroLineas){
      l.display1();
    }
  }
  for(Letra l:texto){
    if(l.y<=interlineado*numeroLineas){
      l.display2();
    }
  }
  if (cambioColor%20 == 0){
    cambiarColores();
  }
}

void keyPressed(){
  if (texto.get(indice).y>abajo){
    indice = 0;
  }
  texto.get(indice).setFont(key);
  texto.get(indice).delta = 0;
  indice++;
  resetFonts();
  cambioColor++;
}

void resetFonts(){
  for (Letra l:texto){
    cuenta++;
    if (px + l.ancho > derecha){
      px = izquierda;
      py+=interlineado;      
    }
    l.reset(px,py);
    px += textWidth(l.c);
  }
  px = izquierda;
  py = arriba;
  cuenta = 0;
}

void cambiarColores(){
  fondo = color (random(255),random(255),random(255));
  bloque = color (random(255),random(255),random(255));
}
