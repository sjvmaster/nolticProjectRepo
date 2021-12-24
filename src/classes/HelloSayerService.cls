/**
 * Created by ivan.sokolov on 23.12.2021.
 */

public with sharing class HelloSayerService {

    private HelloSayer helloSayer;

    public void initHelloSayer(HelloSayer helloSayer){
        this.helloSayer = helloSayer;
    }

    public String sayHello(String name){
        return this.helloSayer.sayHello(name);
    }
}