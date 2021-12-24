/**
 * Created by Ivan.Sokolov on 18.11.2021.
 */
 
trigger CaseTrigger on Case (
            before insert,
            before update,
            before delete,
            after insert,
            after update,
            after delete,
            after undelete) {
    System.debug('Running Case trigger for :' + Trigger.operationType);
    CaseTriggerHandler.handle(Trigger.new, Trigger.oldMap, Trigger.operationType);
}