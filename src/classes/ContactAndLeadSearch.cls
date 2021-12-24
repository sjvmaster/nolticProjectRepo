public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String match){
        List<List<SObject>> result = [
                FIND :match
                IN NAME FIELDS
                        RETURNING Contact(Id, LastName WHERE FirstName=:match OR LastName=:match),
                                  Lead(Id, LastName WHERE FirstName=:match OR LastName=:match)];
        return result;
    }
}