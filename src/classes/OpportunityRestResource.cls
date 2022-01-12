/**
 * Created by Ivan.Sokolov on 26.12.2021.
 */
@RestResource(UrlMapping='/opportunity/*')
global with sharing class OpportunityRestResource {
    final static String lastEndpointSection = 'opportunity';

    private static Date parseCloseDate(String closeDateStr){
        return Date.valueOf(closeDateStr);
    }

    @HttpGet
    global static void getOpportunities() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String opportunityId = req.requestURI.substring(
                req.requestURI.lastIndexOf(lastEndpointSection) + lastEndpointSection.length())
                .removeStart('/');
        if (String.isBlank(opportunityId)) {
            res.headers.put('Content-Type', 'application/json');
            res.statusCode = 200;
            res.responseBody = Blob.valueOf(JSON.serializePretty([
                    SELECT Id, Name, CloseDate, StageName
                    FROM Opportunity
            ]));
        }
        else {
            List<Opportunity> opportunities = [
                    SELECT Id, Name
                    FROM Opportunity
                    WHERE Id = :opportunityId
            ];
            if (opportunities.size() > 0) {
                res.headers.put('Content-Type', 'application/json');
                res.statusCode = 200;
                res.responseBody = Blob.valueOf(JSON.serializePretty(opportunities));
            }
            else {
                res.statusCode = 500;
                res.responseBody = Blob.valueOf('Invalid Opportunity Id: ' + opportunityId);
            }
        }
    }

    @HttpPost
    global static void createOpportunity() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String requestBody = req.requestBody.toString();

        Map<String, Object> opportunityMap = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

        String name =  (String) opportunityMap.get('Name');
        if (String.isBlank(name)) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Name is required in POST request');
            return;
        }
        String closeDateStr = (String) opportunityMap.get('CloseDate');
        if (String.isBlank(closeDateStr)) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('closeDate is required in POST request');
            return;
        }
        Date closeDate = null;
        try {
            closeDate = parseCloseDate(closeDateStr);
        }
        catch (Exception e){
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Invalid closeDate in POST request: ' + closeDateStr);
            return;
        }

        String stageName = (String) opportunityMap.get('StageName');
        if (String.isBlank(stageName)) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('StageName is required in POST request');
            return;
        }
        Opportunity opportunity = null;
        try {
            opportunity = new Opportunity(
                Name = name,
                CloseDate = closeDate,
                StageName = stageName
                );

            insert opportunity;
        }
        catch (Exception e) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf(
                    'Error inserting opportunity: ' + e.getMessage()
            );
            return;
        }

        res.headers.put('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(opportunity));
    }

    @HttpPatch
    global static void updateOpportunity() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String requestBody = req.requestBody.toString();
        String opportunityId = req.requestURI.substring(
                req.requestURI.lastIndexOf(lastEndpointSection) + lastEndpointSection.length())
                .removeStart('/');
        if (String.isBlank(opportunityId)) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Opportunity Id is missing');
            return;
        }
        List<Opportunity> opportunities = [
                SELECT Id, Name, CloseDate, StageName
                FROM Opportunity
                WHERE Id = :opportunityId
        ];
        if (opportunities.size() == 0) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Invalid Opportunity Id: ' + opportunityId);
            return;
        }

        Map<String, Object> opportunityMap = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

        try {
            for (Opportunity opportunity: opportunities) {
                for (String field : opportunityMap.keySet()) {
                    if (field == 'CloseDate') {
                        opportunity.put(field, parseCloseDate((String)opportunityMap.get(field)));
                    }
                    else {
                        opportunity.put(field, opportunityMap.get(field));
                    }
                }
            }
            update opportunities;
        }
        catch (Exception e) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf(
                    'Error updating opportunity: ' + e.getMessage()
            );
            return;
        }

        res.headers.put('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(opportunities));
    }

    @HttpDelete
    global static void deleteOpportunity() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String opportunityId = req.requestURI.substring(
                req.requestURI.lastIndexOf(lastEndpointSection) + lastEndpointSection.length())
                .removeStart('/');

        List<Opportunity> opportunities = [
                SELECT Id, Name, CloseDate, StageName
                FROM Opportunity
                WHERE Id = :opportunityId
        ];
        if (opportunities.size() > 0) {
            try {
                delete opportunities;
            }
            catch (Exception e) {
                res.statusCode = 500;
                res.responseBody = Blob.valueOf(
                        'Error deleting opportunity: ' + e.getMessage()
                );
                return;
            }
        }
        else{
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Invalid Opportunity Id: ' + opportunityId);
            return;
        }

        res.statusCode = 200;
        res.responseBody = Blob.valueOf('Opportunity ' + opportunityId + 'was deleted');
    }
}