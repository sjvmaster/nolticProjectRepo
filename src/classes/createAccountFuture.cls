/**
 * Created by Ivan.Sokolov on 12.01.2022.
 */

public with sharing class createAccountFuture {

    @Future
    public static void createAccount(String accountName){

        try{
            insert new Account(Name=accountName);
        }
        catch (Exception e){
            System.debug(e.getMessage());
        }
    }


}