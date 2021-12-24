/**
 * Created by Ivan.Sokolov on 23.11.2021.
 */

public with sharing class Exam2ContactTriggerHandlerTestFactory {
    public static List<Contact> generateContactsWithAccount(Integer numContacts, Id accountId){
        List<Contact> contacts = new List<Contact>();
        for (Integer i=0; i<numContacts; i++) {
            contacts.add(new Contact(
                    FirstName = 'First Name' + i,
                    LastName = 'Last Name' + i,
                    AccountId = accountId
            ));
        }
        return contacts;
    }
    public static Account generateAccount(String accountName){
        return new Account(Name=accountName); 
    }

}