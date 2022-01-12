/**
 * Created by Ivan.Sokolov on 28.12.2021.
 */
 
public class AccountNameChanger implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator([SELECT Id, Name FROM Account]);
    }
    public void execute(Database.BatchableContext ctx, List<Account> records){
        for (Account acc : records) {
            acc.Name += ' Changed!!!!';
        }

        update records;
    }
    public void finish(Database.BatchableContext ctx){
        System.debug('Finish!!!!');
    }
}