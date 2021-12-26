/**
 * Created by Ivan.Sokolov on 26.12.2021.
 */

public with sharing class EmailNotificationSender implements NotificationSender {

    public void sendNotification(String notificationMessage){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {UserInfo.getUserEmail()};
        System.debug('Current email: ' + toAddresses);
        mail.setToAddresses(toAddresses);
        mail.setSubject('Homework 17 Test');
        mail.setPlainTextBody(notificationMessage);

        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                new Messaging.SingleEmailMessage[] { mail });
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            }
            else {
                System.debug('The following errors occurred: ' + res.getErrors());
            }
        }
    }
}