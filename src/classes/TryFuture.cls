/**
 * Created by Ivan.Sokolov on 28.12.2021.
 */

public with sharing class TryFuture {

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

    @Future
    public static void updateContact(String contactInfo){
        System.debug('Inside updateContact');
        Contact theContact = (Contact) JSON.deserialize(contactInfo, Contact.class);
        theContact.Email = 'tryfuture@email.com';
        update theContact;
    }
}