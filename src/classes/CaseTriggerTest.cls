/**
 * Created by Ivan.Sokolov on 21.11.2021.
 */

@IsTest
public class CaseTriggerTest {
    @IsTest(SeeAllData=true)
    static void testBeforeInsert() {
        // prepare data
        Country__c testCountry = CaseTriggerTestFactory.getCountry('Albania');
        Integer existingCasesWithMessage = CaseTriggerTestFactory.countCasesWithSuccessMessage(testCountry.SuccessMessage__c);
        List<Case> newCases = CaseTriggerTestFactory.generateCasesWithCountryAndStatus(50, testCountry, 'New');
        newCases.addAll(CaseTriggerTestFactory.generateCasesWithCountryAndStatus(150, testCountry, 'Closed'));
        Integer currentClosed = (Integer)testCountry.ClosedCases__c;

        Test.startTest();
        insert newCases;
        Test.stopTest();

        // validate
        testCountry = CaseTriggerTestFactory.getCountry('Albania');
        List<Case> insertedCases = [SELECT Id FROM Case WHERE SuccessMessage__c = :testCountry.SuccessMessage__c];
        System.assert(currentClosed + 150 == testCountry.ClosedCases__c);
        System.assert(existingCasesWithMessage + 150 == insertedCases.size());
    }

    @IsTest(SeeAllData=true)
    static void testBeforeUpdate() {
        // prepare data
        Country__c testCountry = CaseTriggerTestFactory.getCountry('Albania');
        Integer existingCasesWithMessage = CaseTriggerTestFactory.countCasesWithSuccessMessage(testCountry.SuccessMessage__c);
        List<Case> newCases = CaseTriggerTestFactory.generateCasesWithCountryAndStatus(200, testCountry, 'New');
        insert newCases;
        Integer currentClosed = (Integer)testCountry.ClosedCases__c;
        CaseTriggerTestFactory.updateCasesStatus(newCases, 'Closed');

        Test.startTest();
        update newCases;
        Test.stopTest();

        // validate
        testCountry = CaseTriggerTestFactory.getCountry('Albania');
        List<Case> updatedCases = [SELECT Id FROM Case WHERE SuccessMessage__c = :testCountry.SuccessMessage__c];
        System.assert(currentClosed + 200 == testCountry.ClosedCases__c);
        System.assert(existingCasesWithMessage + 200 == updatedCases.size());
    }
}