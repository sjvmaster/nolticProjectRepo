@IsTest
public class TestDataFactory {
    public static List<Contact> getContacts(Integer numberOfContacts){
        List<Contact> contacts = new List<Contact>();
        for (Integer i=0; i<numberOfContacts; i++) {
            contacts.add(new Contact(
                    FirstName = 'First Name' + i,
                    LastName = 'Last Name' + i,
                    Company__c = 'Company',
                    Title = (i > 150) ? 'Test': 'Test test'
            ));
        }
        return contacts;
    }

    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();

        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;

        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                        StageName='Prospecting',
                        CloseDate=System.today().addMonths(1),
                        AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;

        return accts;
    }

}