public class Fighter {
    public String name {get; private set;}
    public Integer damagePerAttack {
        get;
        private set {
            if (damagePerAttack <=0) {
                throw new System.UnexpectedException('Attack cannot be < 0');
            }
            else{
                damagePerAttack = value;
            }
        }
    }
    public Integer health {get; set;}

    public Fighter(String name, Integer health, Integer damagePerAttack) {
        this.name = name;
        if (health <= 0) {
            throw new System.UnexpectedException('cannot create fighter with non-positive health');
        }
        this.health = health;
        this.damagePerAttack = damagePerAttack;
    }
    public Boolean isDead() {
        return this.health <= 0;
    }
    public Boolean takeDamage(Integer damage) {
        if (damage < 0) {
            throw new System.UnexpectedException('cannot take negative damage');
        }
        this.health -= damage;
        return this.isDead();
    }
}