public class Woman extends Human {
    public static Boolean beard = false;
    
    public Woman() {
		super();
    }
    
    public Woman(String name){
        super(name);
    }
    
    public static Boolean get_beard(){
        return beard;
    }
}