/**
 * Created by Ivan.Sokolov on 23.11.2021.
 */

@IsTest
private class Exam2ContactTriggerHandlerTest {
    @IsTest
    static void testInsertTypePersonal() {
        Account testAccount = Exam2ContactTriggerHandlerTestFactory.generateAccount('Exam 2 Test Account');
        insert testAccount;
        List<Contact> testContacts = Exam2ContactTriggerHandlerTestFactory.generateContactsWithAccount(1, testAccount.Id);
        Test.startTest();
        insert testContacts;
        Test.stopTest();
        Account updatedAccount = [SELECT Id, Type__c FROM Account WHERE Id=:testAccount.Id];
        System.assert(updatedAccount.Type__c == 'Personal');
    }
    @IsTest
    static void testInsertTypeBusiness() {
        Account testAccount = Exam2ContactTriggerHandlerTestFactory.generateAccount('Exam 2 Test Account');
        insert testAccount;
        List<Contact> testContacts = Exam2ContactTriggerHandlerTestFactory.generateContactsWithAccount(50, testAccount.Id);
        Test.startTest();
        insert testContacts;
        Test.stopTest();
        Account updatedAccount = [SELECT Id, Type__c FROM Account WHERE Id=:testAccount.Id];
        System.assert(updatedAccount.Type__c == 'Business');
    }
    @IsTest
    static void testInsertTypeCompany() {
        Account testAccount = Exam2ContactTriggerHandlerTestFactory.generateAccount('Exam 2 Test Account');
        insert testAccount;
        List<Contact> testContacts = Exam2ContactTriggerHandlerTestFactory.generateContactsWithAccount(100, testAccount.Id);
        Test.startTest();
        insert testContacts;
        Test.stopTest();
        Account updatedAccount = [SELECT Id, Type__c FROM Account WHERE Id=:testAccount.Id];
        System.assert(updatedAccount.Type__c == 'Company');
    }

    @IsTest
    static void testUpdate() {
        Account testAccount1 = Exam2ContactTriggerHandlerTestFactory.generateAccount('Exam 2 Test Account 1');
        Account testAccount2 = Exam2ContactTriggerHandlerTestFactory.generateAccount('Exam 2 Test Account 2');
        insert testAccount1;
        insert testAccount2;
        List<Contact> testContacts = Exam2ContactTriggerHandlerTestFactory.generateContactsWithAccount(1, testAccount1.Id);
        testContacts.addAll(Exam2ContactTriggerHandlerTestFactory.generateContactsWithAccount(110, testAccount2.Id));
        insert testContacts;
        Integer index = 0;
        for (Contact c: testContacts) {
            if (index > 0 && Math.mod(index, 2) == 0){
                c.AccountId = testAccount1.Id;
            }
            index++;
        }
        Test.startTest();
        update testContacts;
        Test.stopTest();
        Account updatedAccount1 = [SELECT Id, Type__c FROM Account WHERE Id=:testAccount1.Id];
        Account updatedAccount2 = [SELECT Id, Type__c FROM Account WHERE Id=:testAccount2.Id];
        System.assert(updatedAccount1.Type__c == 'Business');
        System.assert(updatedAccount2.Type__c == 'Business');
    }

    @IsTest
    static void testDelete() {
        Account testAccount = Exam2ContactTriggerHandlerTestFactory.generateAccount('Exam 2 Test Account 1');
        insert testAccount;
        List<Contact> testContacts = Exam2ContactTriggerHandlerTestFactory.generateContactsWithAccount(110, testAccount.Id);
        insert testContacts;
        List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE AccountId=:testAccount.Id LIMIT 109];
        Test.startTest();
        delete contactsToDelete;
        Test.stopTest();
        Account updatedAccount = [SELECT Id, Type__c FROM Account WHERE Id=:testAccount.Id];
        System.assert(updatedAccount.Type__c == 'Personal');
    }
}