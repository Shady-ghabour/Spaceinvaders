int pixelsize = 4;
int gridsize  = pixelsize * 7 + 5;
Player player;
ArrayList enemies = new ArrayList();
ArrayList bullets = new ArrayList();
int direction = 1;
boolean incy = false;
int score = 0;
PFont f;
boolean PowerUpRelease = false;
boolean PowerUpCollected = false;
int PowerUpx;
int PowerUpy;
int Playerx;
int Playery;
int PowerUpTime = millis();
int PowerUpReleaseTimeStop = 0;


void setup() {
    background(0);
    noStroke();
    size(800, 550);
    player = new Player();
    createEnemies();

    f = createFont("Arial", 36, true);
}

void draw() {
    background(0);
    fill(255);
    drawScore();
    fill(245,12,43);
    rect(0,500,800,5);
    fill(255);
    textSize(20);
/*******************Debug********************/    
    if (PowerUpCollected == true)
     {
       text("PowerUpCollected:true",10,20);
     } else {
       text("PowerUpCollected:false",10,20);
     }
     text(millis(),10,50);
     text(PowerUpReleaseTimeStop,10,80);
/***************************************************/
     
     
    player.draw();
    

    for (int i = 0; i < bullets.size(); i++) {
        Bullet bullet = (Bullet) bullets.get(i);
        bullet.draw();
    }

    for (int i = 0; i < enemies.size(); i++) {
        Enemy enemy = (Enemy) enemies.get(i);
        if (enemy.outside() == true) {
            direction *= (-1);
            incy = true;
            break;
        }
    }

    for (int i = 0; i < enemies.size(); i++) {
        Enemy enemy = (Enemy) enemies.get(i);
        if (!enemy.alive()) {
            enemies.remove(i);
        } else {
            enemy.draw();
        }
    }

    incy = false;
    
    /*******************PowerUpSystem********************/ 
    if (PowerUpRelease == true){
     powerUp(PowerUpx,PowerUpy); 
     PowerUpy++;
     if (PowerUpy >= height){
      PowerUpRelease = false; 
     }
     if ((PowerUpCollected == false) && (PowerUpx >= Playerx) && (PowerUpy >= Playery ))
     {
      PowerUpCollected = true; 
      PowerUpRelease = false;
      PowerUpx = 0;
      PowerUpy = 0;
     }
   
    
    }
     if((PowerUpCollected == true) && (millis() >= PowerUpReleaseTimeStop )){
     PowerUpCollected = false; 
    }
    /***************************************/ 
}

/*******************Scoreboard********************/ 
void drawScore() {
    textFont(f);
    text("Score: " + String.valueOf(score), 300, 50);
}
/**************************************/ 

//Klasse for enemy lavet udfra Spaceship - 

class Enemy extends SpaceShip {
    int life = 3;
    
    //Enemy pixelart samt x og y positioner
    Enemy(int xpos, int ypos) {
        x = xpos;
        y = ypos;
        PixelRow    = new String[5];
        PixelRow[0] = "1011101";
        PixelRow[1] = "0101010";
        PixelRow[2] = "1111111";
        PixelRow[3] = "0101010";
        PixelRow[4] = "0000000";
    }
// Opdaterer enemies position, både i x og y, udfra framecount
    void updateObj() {
        if (frameCount%30==0) {
            x += direction * gridsize;
        }
        
        if (incy == true) {
            y += gridsize / 2;
        }
    }
//Scoresystem - Hvis bullets koordinater er de samme som enemy, fjerner den skudet, gør enemy rød og fjerner 1 liv fra enemy. Hvis life == 0, dør enemy og scoren stiger med 50
    boolean alive() {
        for (int i = 0; i < bullets.size(); i++) {
            Bullet bullet = (Bullet) bullets.get(i);
            
            if (bullet.x > x && bullet.x < x + 7 * pixelsize + 5 && bullet.y > y && bullet.y < y + 5 * pixelsize) {
                bullets.remove(i);
                
                life--;
                nextColor = color(255, 0, 0);
                //Når enemy dør er der en 25% chance for at droppe en powerup
                if (life == 0) {
                    score += 50;
                int powerUp = int(random(0,10));
                if (powerUp == 0 && PowerUpRelease == false ){
                
                  PowerUpRelease = true;
                  PowerUpx = x + 7 * pixelsize + 5;
                  PowerUpy = y + 5 * pixelsize;
                  
                  PowerUpReleaseTimeStop = millis()+10*1000;
                  
                }
                
                   
                    return false;
                }
                
                break;
            }
        }

        return true;
    }
    

    boolean outside() {
        return x + (direction*gridsize) < 0 || x + (direction*gridsize) > width - gridsize;
    }
}
