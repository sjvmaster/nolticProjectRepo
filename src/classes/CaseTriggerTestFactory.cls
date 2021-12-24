/**
 * Created by Ivan.Sokolov on 21.11.2021.
 */ 

public with sharing class CaseTriggerTestFactory {
    public static List<Case> generateCasesWithCountryAndStatus(Integer numCases, Country__c country, String status){
        List<Case> cases = new List<Case>();
        for (Integer i=0; i<numCases; i++){
            cases.add(
                    new Case(
                            Subject='Test1',
                            Country__c = country.Id,
                            Status = status)
            );
        }
        return cases;
    }

    public static void updateCasesStatus(List<Case> cases, String status){
        for (Case c : cases) {
            c.Status = status;
        }
    }

    public static Country__c getCountry(String countryName){
        Country__c country = [SELECT Id, ClosedCases__c, SuccessMessage__c FROM Country__c WHERE Name = :countryName LIMIT 1];
        return country;
    }

    public static Integer countCasesWithSuccessMessage(String message){
        return [SELECT COUNT() FROM Case WHERE SuccessMessage__c = :message];
    }
}