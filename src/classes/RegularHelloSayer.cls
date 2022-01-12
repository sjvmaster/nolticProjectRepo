/**
 * Created by ivan.sokolov on 23.12.2021.
 */

public with sharing class RegularHelloSayer implements HelloSayer {
    private String name;

    public RegularHelloSayer(String name){
        this.name = name;
    }

    public String sayHello(String name) {
        String hello = 'Hello, ' + this.name;
        return hello;
    }
}