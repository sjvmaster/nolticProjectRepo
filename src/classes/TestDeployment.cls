/**
 * Created by Ivan.Sokolov on 11.01.2022.
 */

public with sharing class TestDeployment {
    @Future
    public static void createContact(String lastName, String firstName){
        System.debug('Inside createContact');
        try{
            insert new Contact(FirstName=firstName, LastName=lastName);
        }
        catch (Exception e){
            System.debug(e.getMessage());
        }
    }
}