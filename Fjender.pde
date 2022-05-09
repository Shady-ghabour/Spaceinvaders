
    
void createEnemies() {
    for (int i = 0; i < width/gridsize/2; i++) {
        for (int j = 0; j <= 1;j++) {
            enemies.add(new Enemy(i*gridsize, j*gridsize + 70));
        }
    }
}
