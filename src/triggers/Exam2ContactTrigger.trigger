/**
 * Created by Ivan.Sokolov on 23.11.2021.
 */

trigger Exam2ContactTrigger on Contact (
        before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {
    Exam2ContactTriggerHandler.handle(Trigger.new, Trigger.oldMap, Trigger.operationType); 
}