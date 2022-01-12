/**
 * Created by Ivan.Sokolov on 26.12.2021.
 */

public with sharing class ObjectNotificationSender implements NotificationSender {

    public void sendNotification(String notificationMessage){
        Notification__c notification = new Notification__c(Notification_Message__c=notificationMessage);
        try{
            insert notification;
        }
        catch (Exception e){
            System.debug('The following errors occurred: ' + e.getMessage());
        }
    }

}