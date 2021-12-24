public class ContactUtility {
    public static void viewContacts(){
        List<Contact> listOfContacts = [SELECT FirstName, LastName FROM Contact];
        for (Contact con : listOfContacts){
            String fullName = 'First Name: ' + con.FirstName + ', Last Name: ' + con.LastName;
            System.debug(fullName);
        }
    }
    public static void viewAnnualRevenue(){
        List<Account> accountsList = [SELECT Name, AnnualRevenue FROM Account];
        for (Account acc : accountsList) {
            String acctRev = acc.Name + ' : '  + acc.AnnualRevenue;
            System.debug(acctRev);
        }
    }
}