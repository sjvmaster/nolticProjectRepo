trigger ContactTrigger on Contact (
        before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {
    for (Contact contact: Trigger.new){
        if (contact.Title == 'Test'){
            contact.addError('Don\'t name contact with Test title');
        }
    }
}