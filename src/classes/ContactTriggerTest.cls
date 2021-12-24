@IsTest 
private class ContactTriggerTest {
    @TestSetup
    static void setup(){
        Contact contact = TestDataFactory.getContacts(1)[0];
        insert contact;
    }
    @IsTest
    static void insertContactPositive() {
//        Contact contact = TestDataFactory.getContacts(1)[0];
//        Test.startTest();
//        insert contact;
//        Test.stopTest();
        List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName LIKE 'Last Name%'];
        System.assert(1 == contacts.size());
    }

    @IsTest
    static void insertContactNegative() {
        Contact contact = new Contact(
                FirstName = 'First Name',
                LastName = 'Last Name',
                Title = 'Test'
        );
        Test.startTest();
        try {
            insert contact;
        }
        catch (DmlException e) {
            System.assert(e.getMessage().contains('Don\'t name contact with Test title'));
        }
        Test.stopTest();
        List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName = 'Last Name'];
        System.assert(0 == contacts.size());
    }

    @IsTest
    static void insertBulkContactPositive() {
        List<Contact> contacts = TestDataFactory.getContacts(300);
        Test.startTest();
        Database.insert(contacts, false);
        Test.stopTest();
        List<Contact> testContacts = [SELECT Id FROM Contact WHERE LastName LIKE 'Last Name%'];
        System.assert(151 == testContacts.size());
    }
}