/**
 * Created by Ivan.Sokolov on 18.11.2021.
 */

public with sharing class CaseTriggerHandler {
    private static void updateCountryClosedCases(List<Case> newRecords, Map<Id, Case> oldRecordsMap){
        // Get Id's of countries in new/updated closed Cases if they have a country
        Map<Id, Integer> countriesNewClosedCases = new Map<Id, Integer>();
        for (Case newCase: newRecords){
            if (newCase.Country__c != null) {
                if (newCase.Status == 'Closed'
                        && (oldRecordsMap == null || newCase.Status != oldRecordsMap.get(newCase.Id).Status)) {
                    if (!countriesNewClosedCases.containsKey(newCase.Country__c)) {
                        countriesNewClosedCases.put(newCase.Country__c, 1);
                    }
                    else {
                        countriesNewClosedCases.put(newCase.Country__c, countriesNewClosedCases.get(newCase.Country__c) + 1);
                    }
                }
            }
        }
        System.debug(countriesNewClosedCases);
        // get Countries info
        Map<Id, Country__c> countriesToUpdateMap = new Map<Id, Country__c>([
                SELECT Id, Name, ClosedCases__c, SuccessMessage__c
                FROM Country__c
                WHERE Id IN :countriesNewClosedCases.keySet()
        ]);
        System.debug(countriesToUpdateMap);

        // Set Received message for new/updated closed Cases
        for (Case newCase: newRecords){
            if (newCase.Country__c != null) {
                if (newCase.Status == 'Closed'
                        && (oldRecordsMap == null || newCase.Status != oldRecordsMap.get(newCase.Id).Status)) {
                    newCase.SuccessMessage__c = countriesToUpdateMap.get(newCase.Country__c).SuccessMessage__c;
                }
            }
        }
        // update countries info
        for (Id countryId:countriesToUpdateMap.keySet()){
            countriesToUpdateMap.get(countryId).ClosedCases__c += countriesNewClosedCases.get(countryId);
        }
        System.debug(countriesToUpdateMap);
        if (countriesToUpdateMap.size() > 0) {
            update countriesToUpdateMap.values();
        }
    }
 
    public static void handle(List<Case> newRecords, Map<Id, Case> oldRecordsMap, TriggerOperation operationType){
        switch on operationType {
            when BEFORE_INSERT, BEFORE_UPDATE {
                updateCountryClosedCases(newRecords, oldRecordsMap);
            }
        }
    }

//    public static void testTrigger() {
//        List<Case> newCases = new List<Case>();
//        Country__c albania = [SELECT Id FROM Country__c WHERE Name = 'Albania' LIMIT 1];
//        Case case1 = new Case(Subject='Test1', Country__c = albania.Id, Status = 'New');
//        Case case2 = new Case(Subject='Test2', Country__c = albania.Id, Status = 'Closed');
//        Case case3 = new Case(Subject='Test3', Country__c = albania.Id, Status = 'Closed');
//        newCases.add(case1);
//        newCases.add(case2);
//        newCases.add(case3);
//        insert newCases;
//        // handle(newCases, null, TriggerOperation.BEFORE_INSERT);
//
//        albania = [SELECT Id, Name, ClosedCases__c FROM Country__c WHERE Name = 'Albania'];
//        System.debug(albania);
//
//        case1 = [SELECT Id, Status FROM Case WHERE Id = :newCases.get(0).Id];
//        case1.Status = 'Closed';
//        update case1;
//        case1 = [SELECT Id, Status, SuccessMessage__c FROM Case WHERE Id = :newCases.get(0).Id];
//        System.debug(case1);
//        albania = [SELECT Id, Name, ClosedCases__c FROM Country__c WHERE Name = 'Albania'];
//        System.debug(albania);
//    }
}