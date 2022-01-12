/**
 * Created by Ivan.Sokolov on 12.01.2022.
 */

public with sharing class ChangeAccountNamesBatch implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator([SELECT Id, Name FROM Account]);
    }
    public void execute(Database.BatchableContext ctx, List<Account> records){
        for (Account acc : records) {
            acc.Name += ' Batch Processed';
        }

        update records;
    }
    public void finish(Database.BatchableContext ctx){
        System.debug('Batch Processed');
    }
}