public class AccountHandler { 
    public static void insertAccount(Integer numAccounts) {
        List<Account> addAccounts = new List<Account>();
        Integer index = 1;
        while (index <= numAccounts) {
            Account newAccount = new Account(
                Name='Acme Inc ' + index,
                AccountNumber='A000' + index
            );
            addAccounts.add(newAccount);
            index++;
        }
        insert addAccounts;
    }

    public static Account insertNewAccount(String accountName){
        Account newAccount = new Account(name=accountName);
        try {
            insert newAccount;
        }
        catch (DmlException e) {
            System.debug('A DML exception has occurred: ' + e.getMessage());
            newAccount = null;
        }
        return newAccount;
    }
}