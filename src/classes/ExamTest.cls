@IsTest
private class ExamTest {
    private static Integer PERSONAL_SIZE = 1;
    private static Integer BUSINESS_SIZE = 10;
    private static Integer COMPANY_SIZE = 100;
    private static String PERSONAL_TYPE = 'Personal';
    private static String BUSINESS_TYPE = 'Business';
    private static String COMPANY_TYPE = 'Company';
    
    @TestSetup
    static void setup() {
        Account account = new Account(Name='Test');
        insert account;
    }
    
    @IsTest
    static void personType() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        List<Contact> contacts = createContact(PERSONAL_SIZE, account);
        insert contacts;
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(PERSONAL_TYPE, account.Type__c);
    }
    
    @IsTest
    static void bussinesType() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        List<Contact> contacts = createContact(BUSINESS_SIZE, account);
        insert contacts;
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(BUSINESS_TYPE, account.Type__c);
    }
    
    @IsTest
    static void companyType() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        List<Contact> contacts = createContact(COMPANY_SIZE, account);
        insert contacts;
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(COMPANY_TYPE, account.Type__c);
    }
    
    @IsTest
    static void deleteFewContacts() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        List<Contact> contacts = createContact(BUSINESS_SIZE, account);
        insert contacts;
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(BUSINESS_TYPE, account.Type__c);
        contacts.remove(0);
        delete contacts;
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(PERSONAL_TYPE, account.Type__c);
    }
    
    @IsTest
    static void deleteAllContacts() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        List<Contact> contacts = createContact(PERSONAL_SIZE, account);
        insert contacts;
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(PERSONAL_TYPE, account.Type__c);
        
        delete contacts;
        
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(null, account.Type__c);
    }
    
    @IsTest
    static void updateAccount() {
        Account account = [SELECT Id FROM Account LIMIT 1];		
        List<Contact> contacts = createContact(BUSINESS_SIZE, account);
        insert contacts;
        
        update account;
        account = [SELECT Id, Type__c FROM Account WHERE Id=:account.Id];
        System.assertEquals(BUSINESS_TYPE, account.Type__c);
    }
    
    private static List<Contact> createContact(Integer size, Account account) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < size; i++) {
            contacts.add(new Contact(LastName=i.format(),AccountId=account.Id));
        }
        return contacts;
    }
}