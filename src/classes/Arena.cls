public class Arena { 
    public static String Fight(Fighter fighter1, Fighter fighter2) {
        Boolean isFighterDead = false;
        Fighter victor = null;
        while (true) {
            isFighterDead = fighter2.takeDamage(fighter1.damagePerAttack);
            if (isFighterDead) {
                victor = fighter1;
                break;
            }
            isFighterDead = fighter1.takeDamage(fighter2.damagePerAttack);
            if (isFighterDead) {
                victor = fighter2;
                break;
            }
        }
        return victor.name;
    }

    public static void testFight(){
        Fighter f1 = new Fighter('dummy1', 150, 10);
        Fighter f2 = new Fighter('dummy2', 150, 10);
        System.debug(String.format('{0} is victorious', new String[] { Arena.Fight(f1, f2)}));
    }

}