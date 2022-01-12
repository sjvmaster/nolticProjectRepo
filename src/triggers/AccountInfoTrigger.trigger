trigger AccountInfoTrigger on Account_Info__e (after insert) {
    List<Account> accounts = new List<Account>();
    System.debug('Trigger.new size' + Trigger.new.size());
    for (Account_Info__e accInfo: Trigger.new) {
        System.debug('accInfo.Account_Name__c = ' + accInfo.Account_Name__c);
        accounts.add(new Account(Name = accInfo.Account_Name__c));
    }

    insert accounts;
    System.debug('Inside of AccountInfoTrigger event trigger');
}