class SpaceShip {
    int x, y;
    String sprite[];
    color baseColor = color(255, 255, 255);
    color nextColor = baseColor;
    color Test = color(121,27,180);
    

    void draw() {
        updateObj();
        drawSprite(x, y);
    }

    void drawSprite(int xpos, int ypos) {
        fill(nextColor);
        if (ypos < 510){
         fill(Test); 
        }
        nextColor = baseColor;
      
        for (int i = 0; i < sprite.length; i++) {
            String row = (String) sprite[i];

            for (int j = 0; j < row.length(); j++) {
                if (row.charAt(j) == '1') {
                    rect(xpos+(j * pixelsize), ypos+(i * pixelsize), pixelsize, pixelsize);
                }
            }
        }
    }

    void updateObj() {
    }
}



class Player extends SpaceShip {
    boolean canShoot = true;
    int shootdelay = 0;
    boolean canDie = false;
    Player() {
        x = width/gridsize/2;
        y = height - (10 * pixelsize);
        //Rumskibets pixelart - 0 er sort 1 er hvid. Den er lavet med 5 rækker
        sprite    = new String[5];
        sprite[0] = "0001000";
        sprite[1] = "0011100";
        sprite[2] = "0111110";
        sprite[3] = "1111111";
        sprite[4] = "1111111";
    }
//Bevægelse højre og venstre ved brug af <- og ->
    void updateObj() {
        if (keyPressed && keyCode == LEFT) {
            x -= 5;
        }
        
        if (keyPressed && keyCode == RIGHT) {
            x += 5;
        }
//Tjekker om control er trykket og om rumskibet kan skyde - Sørger for at spilleren ikke kan skyde med uendelig hastighed
        if (keyPressed && keyCode == CONTROL && canShoot) {
            bullets.add(new Bullet(x, y));
            canShoot = false;
            shootdelay = 0;
        }
//Giver skudene en delay som ovenfor
        shootdelay++;
        
        if (shootdelay >=20) {
            canShoot = true;
        }
    }
}
