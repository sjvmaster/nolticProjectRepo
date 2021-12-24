/**
 * Created by Ivan.Sokolov on 07.12.2021.
 */

public with sharing class OpportunityController {
    @AuraEnabled(Cacheable=true)
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId){
        return [SELECT Id, Name, StageName, Amount, CloseDate FROM Opportunity WHERE AccountId =:accountId];
    }

    @AuraEnabled
    public static void addOpportunity(Id accountId, String name){
        insert new Opportunity(
                AccountId=accountId,
                Name=name,
                StageName='Prospecting',
                Amount=20000,
                CloseDate=Date.newInstance(2022, 10, 27));
    }
}