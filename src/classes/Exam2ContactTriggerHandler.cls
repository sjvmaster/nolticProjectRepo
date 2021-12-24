/**
 * Created by Ivan.Sokolov on 16.11.2021.
 */

public with sharing class Exam2ContactTriggerHandler {

    private static String getAccountType(Integer numContacts) {
        if (numContacts == 1) {
            return 'Personal';
        }
        else if (numContacts < 100) {
            return 'Business';
        }
        else {
            return 'Company';
        }
    }

    private static void updateRelatedAccounts(List<Id> updatedAccountIds){
        List<Account> accountsToUpdate = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :updatedAccountIds];
        for (Account a:accountsToUpdate){
            a.Type__c = getAccountType(a.Contacts.size());
        }
        update accountsToUpdate;
    }

    private static void onAfterInsert(List<Contact> newRecords){
        List<Id> updatedAccountIds = new List<Id>();
        for (Contact acc : newRecords) {
            if (acc.AccountId != null){
                updatedAccountIds.add(acc.AccountId);
            }
        }
        updateRelatedAccounts(updatedAccountIds);
    }

    private static void onAfterUpdate(List<Contact> newRecords, Map<Id, Contact> oldRecordsMap){
        List<Id> updatedAccountIds = new List<Id>();
        for (Contact acc : newRecords) {
            if (acc.AccountId != oldRecordsMap.get(acc.Id).AccountId){
                updatedAccountIds.add(acc.AccountId);
                updatedAccountIds.add(oldRecordsMap.get(acc.Id).AccountId);
            }
        }
        updateRelatedAccounts(updatedAccountIds);
    }

    private static void onAfterDelete(Map<Id, Contact> oldRecordsMap) {
        List<Id> updatedAccountsIds = new List<Id>();
        for (Contact acc : oldRecordsMap.values()) {
            updatedAccountsIds.add(acc.AccountId);
        }
        updateRelatedAccounts(updatedAccountsIds);
    }

    public static void handle(List<Contact> newRecords, Map<Id, Contact> oldRecordsMap, TriggerOperation operationType){

        switch on operationType {
            when AFTER_INSERT {
                onAfterInsert(newRecords);
            }
            when AFTER_UPDATE {
                onAfterUpdate(newRecords, oldRecordsMap);
            }
            when AFTER_DELETE {
                onAfterDelete(oldRecordsMap);
            }
        }
    }
}