public with sharing class Service {
    public Integer sum(Integer i1, Integer i2){
        if (false) {
            Integer i = 10;
            i+=2;
            System.debug('no');
        }
        System.debug('i1 + i2');
        return i1 + i2;
    }

}