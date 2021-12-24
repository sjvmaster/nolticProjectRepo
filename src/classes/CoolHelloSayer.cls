/**
 * Created by ivan.sokolov on 23.12.2021.
 */

public with sharing class CoolHelloSayer implements HelloSayer {
    public String sayHello(String name) {
        String hello = 'Yo, bro ' + name;
        return hello;
    }
}