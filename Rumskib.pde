class SpaceShip {
    int x, y;
    String PixelRow[];
    color baseColor = color(255, 255, 255);
    color nextColor = baseColor;
    color Test = color(121,27,180);
    

    void draw() {
        updateObj();
        drawPixelRow(x, y);
    }
//Tegner pixels i hele spillet, både spilleren og enemies
    void drawPixelRow(int xpos, int ypos) {
        fill(nextColor);
        if (ypos < 510){
         fill(Test); 
        }
        nextColor = baseColor;
      
        for (int i = 0; i < PixelRow.length; i++) {
            String row = (String) PixelRow[i];

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


//Player klassen lavet ud fra Spaceship klasse
class Player extends SpaceShip {
    boolean canShoot = true;
    int shootdelay = 0;
    //Spillerens startposition
    Player() {
        x = width/gridsize/2;
        y = height - (10 * pixelsize);
        //Rumskibets pixelart - 0 er sort 1 er hvid. Den er lavet med 5 rækker med en arraylist
        PixelRow    = new String[5];
        PixelRow[0] = "0001000";
        PixelRow[1] = "0001000";
        PixelRow[2] = "1011101";
        PixelRow[3] = "1111111";
        PixelRow[4] = "1011101";
        Playerx = x;
        Playery = y;
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
        //Her inkluderes PowerUp systemmet, som 1/2 skudenes delay og spilleren skyder 2x hurtigere
        if (shootdelay >=20 && PowerUpCollected == false) {
            canShoot = true;
        } else if(shootdelay >=10 && PowerUpCollected == true){
         canShoot = true; 
        }
    }
}
