/**
 * Created by Ivan.Sokolov on 16.11.2021.
 */
  
public with sharing class AccountTriggerHandler {

    public static Boolean isDisabled = false;

    private static void onBeforeInsert(List<Account> newRecords){
        setDescription(newRecords, null);
    }

    private static void onBeforeUpdate(List<Account> newRecords, Map<Id, Account> oldRecordsMap){
        setDescription(newRecords, oldRecordsMap);
    }

    private static void setDescription(List<Account> newRecords, Map<Id, Account> oldRecordsMap) {
        for (Account acc: newRecords) {
            if (oldRecordsMap == null || acc.Name != oldRecordsMap.get(acc.Id).Name) {
                acc.Description = 'Account Name changed : ' + acc.Name;
            }
        }
    }

    public static void handle(List<Account> newRecords, Map<Id, Account> oldRecordsMap, TriggerOperation operationType){
        if (isDisabled) return;

        switch on operationType {
            when BEFORE_INSERT {
                onBeforeInsert(newRecords);
            }
            when BEFORE_UPDATE {
                onBeforeUpdate(newRecords, oldRecordsMap);
            }
        }
    }
}