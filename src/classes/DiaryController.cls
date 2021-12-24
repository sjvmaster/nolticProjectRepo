/**
 * Created by Ivan.Sokolov on 14.12.2021.
 */

public with sharing class DiaryController {
    @AuraEnabled(Cacheable=true)
    public static List<Diary__c> getDiaryNotesByContactId(Id contactId){
        return [SELECT Id, Created_Date__c, Note__c FROM Diary__c WHERE Contact__c =:contactId];
    }

    @AuraEnabled
    public static void addDiaryNote(Id contactId, String note){
        Date createdDate = System.Date.today();
        insert new Diary__c(
                Contact__c=contactId,
                Note__c=note,
                Created_Date__c=createdDate);
    }
}