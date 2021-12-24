/**
 * Created by Ivan.Sokolov on 16.11.2021.
 */

trigger AccountTrigger on Account (
        before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

    AccountTriggerHandler.handle(Trigger.new, Trigger.oldMap, Trigger.operationType); 

}