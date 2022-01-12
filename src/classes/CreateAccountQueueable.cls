/**
 * Created by Ivan.Sokolov on 12.01.2022.
 */

public with sharing class CreateAccountQueueable implements Queueable {
    private String accountName;
    public CreateAccountQueueable(String accountName) {
        this.accountName = accountName;
    }

    public void execute(QueueableContext ctx){
        try{
            System.debug('Testing CreateAccountQueueable.execute');
            insert new Account(Name=this.accountName);
        }
        catch (Exception e){
            System.debug(e.getMessage());
        }
    }
}