int pixelsize = 4;
int gridsize  = pixelsize * 7 + 5;
Player player;
ArrayList enemies = new ArrayList();
ArrayList bullets = new ArrayList();
int direction = 1;
boolean incy = false;
int score = 0;
PFont f;


void setup() {
 db = new SQLite(this, "mydatabase.sqlite");
  if(db.connect()){
  if(input.length()>0 && pwinput.length()>0){
    db.query(insert);
  }
  db.query(check);
  while(db.next()){
    isLogged = true;
  }
} 
    background(0);
    noStroke();
    size(800, 550);
    player = new Player();
    createEnemies();

    f = createFont("Arial", 36, true);
}

void draw() {
  if(isLogged){

    background(0);
    fill(255);
    drawScore();
    fill(245,12,43);
    rect(0,500,800,5);
    fill(255);
 
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
} else {
textSize(50);
textAlign(CENTER);
fill(255);
text("Login Failed ;(", width/2, height/2);
}

}
void drawScore() {
    textFont(f);
    text("Score: " + String.valueOf(score), 300, 50);
}

//Klasse for enemy lavet udfra Spaceship - 
class Enemy extends SpaceShip {
    int life = 3;
    
    Enemy(int xpos, int ypos) {
        x = xpos;
        y = ypos;
        sprite    = new String[5];
        sprite[0] = "1011101";
        sprite[1] = "0101010";
        sprite[2] = "1111111";
        sprite[3] = "0101010";
        sprite[4] = "0000000";
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
                
                if (life == 0) {
                    score += 50;
                int powerUp = int(random(0,5));
                if (powerUp == 0 ){
                  fill(255);
                  rect(0,0,100,100);
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
