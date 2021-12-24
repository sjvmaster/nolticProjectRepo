public virtual class Human {
	public String name;
    
    public Human(String name){
        this.name = name;
    }
    public Human(){
        this('Default');
    }
    public String getName(){
        return name;
    }
}