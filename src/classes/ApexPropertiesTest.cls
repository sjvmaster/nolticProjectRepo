/**
 * Created by Ivan.Sokolov on 04.11.2021.
 */ 

public with sharing class ApexPropertiesTest {
    public String myAwesomeString{
        private get;
        
        set {
            myAwesomeString = value;
            System.debug(value);
        }
    }

}