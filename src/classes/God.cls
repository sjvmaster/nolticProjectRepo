public class God {
   
    public static Man createMan(String name) {
        return new Man(name);
    }
    public static Woman createWoman(String name) {
        return new Woman(name);
    }
}