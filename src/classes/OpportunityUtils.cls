/**
 * Created by Ivan.Sokolov on 15.11.2021.
 */

public with sharing class OpportunityUtils {
    public static List<String> getOpportunityStagesPicklistStrings (){
        List<Schema.PicklistEntry> opportunityStages = Opportunity.StageName.getDescribe().getPicklistValues();
        List<String> opportunityStagesStrings = new List<String>();
        for (Schema.PicklistEntry opportunityStage : opportunityStages){
            opportunityStagesStrings.add(opportunityStage.getValue());
        }
        return opportunityStagesStrings;
    }

    public static List<Opportunity> updateOpportunityStage(String oldStage, String newStage){
        List<String> opportunityStages = getOpportunityStagesPicklistStrings();
        if (!opportunityStages.contains(oldStage)) {
            throw new System.UnexpectedException('Following stage is not supported: ' + oldStage);
        }
        if (!opportunityStages.contains(newStage)) {
            throw new System.UnexpectedException('Following stage is not supported: ' + newStage);
        }
        List<Opportunity> opportunities = [SELECT Id, StageName FROM Opportunity WHERE StageName=:oldStage];
        for (Opportunity opp : opportunities){
            opp.StageName = newStage;
        }
        update opportunities;
        return opportunities;
    }

    public static void updateOpportunityStageTest(){
        List<String> opportunityStages = getOpportunityStagesPicklistStrings();

        System.debug(opportunityStages);
        String oldStage = 'Needs Analysis';
        String newStage = 'Value Proposition';
        List<Opportunity> opportunities = updateOpportunityStage(oldStage, newStage);
        System.debug(opportunities); 
    }

}