public class ContactSearch {
    public static List<Contact> searchForContacts(String searchLastName, String searchMailingPostalCode){
        List<Contact> resultList = [
                SELECT Id, Name
                FROM Contact
                WHERE LastName=:searchLastName AND MailingPostalCode=:searchMailingPostalCode];
        return resultList;
    }
}