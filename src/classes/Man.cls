public class Man extends Human {
    public static Boolean beard = true;
    
    public Man() {
		super();
    }
    
    public Man(String name){
        super(name);
    }
    
    public static Boolean get_beard(){
        return beard;
    }
}