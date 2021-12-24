/**
 * Created by Ivan.Sokolov on 21.11.2021.
 */

@IsTest
private class TestVerifyDate {
    @IsTest
    static void testDate2Within30Days() {
        Date date1 = Date.newInstance(2021, 1, 1);
        Date date2 = Date.newInstance(2021, 1, 27);
        Date dt = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, dt);
    }

    @IsTest
    static void testDate2BeforeDate1() {
        Date date1 = Date.newInstance(2021, 2, 28);
        Date date2 = Date.newInstance(2021, 2, 1);
        Date dt = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date1, dt);
    }

    @IsTest
    static void testDate2NotWithin30Days() {
        Date date1 = Date.newInstance(2021, 1, 31);
        Date date2 = Date.newInstance(2021, 3, 2);
        Date dt = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date1, dt);
    }
}