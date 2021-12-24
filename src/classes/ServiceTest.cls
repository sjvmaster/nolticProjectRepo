/**
 * Created by Ivan.Sokolov on 18.11.2021.
 */

@IsTest
private class ServiceTest {
    @IsTest
    static void testBehavior() {
        System.assertEquals(4, new Service().sum(2, 2));
    }

    @IsTest
    static void testNegativeBehavior() {
        System.assertNotEquals(4, new Service().sum(1, 2));
    }
}