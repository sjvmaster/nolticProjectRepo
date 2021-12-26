/**
 * Created by Ivan.Sokolov on 26.12.2021.
 */

@RestResource(UrlMapping='/account/*')
global class TestRest {
    final static String lastEndpointSection = 'account';
    @HttpGet
    global static void getAccounts() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(
                req.requestURI.lastIndexOf(lastEndpointSection) + lastEndpointSection.length())
                .removeStart('/');
        if (String.isBlank(accountId)) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Account Id is missing');
            return;
        }
        res.headers.put('Content-Type', 'application/json');
        res.statusCode = 200;
        res.responseBody = Blob.valueOf(JSON.serializePretty([
                SELECT Id, Name
                FROM Account
                WHERE Id = :accountId
        ]));
    }

    @HttpPost
    global static void createAccount() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String requestBody = req.requestBody.toString();

        Map<String, Object> accountMap = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

        Account account = new Account(Name = (String) accountMap.get('name'));
        insert account;

        res.responseBody = Blob.valueOf(JSON.serialize(account));
        res.headers.put('Content-Type', 'application/json');

    }

}