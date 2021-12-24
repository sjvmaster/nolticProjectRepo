/**
 * Created by Ivan.Sokolov on 21.11.2021.
 */

@IsTest
private class TestRestrictContactByName {
    @IsTest
    static void testInsert() {
        List<Contact> contacts = new List<Contact>();
        for (Integer i=0; i<200; i++) {
            Contact c = new Contact(LastName='INVALIDNAME');
            contacts.add(c);
        }
        Test.startTest();
        try {
            insert contacts;
        }
        catch (DmlException e) {
            System.assert(e.getMessage().contains('not allowed for DML'));
        }
        Test.stopTest();
        List<Contact> insertedContacts = [SELECT Id FROM Contact WHERE LastName='INVALIDNAME'];
        System.assert(insertedContacts.size()==0);

    }
}