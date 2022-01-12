/**
 * Created by Ivan.Sokolov on 26.12.2021.
 */

public with sharing class NotificationSenderService {

    private NotificationSender notificationSender;
    private String notificationMessage;

    public void initNotificationSender(NotificationSender sender, String message){
        this.notificationSender = sender;
        this.notificationMessage = message;
    }

    public void executeSend(){
        this.notificationSender.sendNotification(this.notificationMessage);
    }
}