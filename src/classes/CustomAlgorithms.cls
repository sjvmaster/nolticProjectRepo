/**
 * Created by Ivan.Sokolov on 10.11.2021.
 */

public with sharing class CustomAlgorithms {

    public static Set<Integer> getUniques(List<Integer> integers) {
        return new Set<Integer>(integers);
    }

    public static Contact getContactByName(List<Contact> contacts, String name){
        Contact res = null;
        for (Contact c: contacts) {
            if (c.Name == name) {
                res = c;
                break;
            }
        }
        return res;
    }

    public static Opportunity getMaxAmountOpportunity(List<Opportunity> opportunities) {
        Opportunity res = null;
        Decimal max_value = -100000000000000000.0;
        for (Opportunity opp: opportunities) {
            if (opp.Amount > max_value) {
                res = opp;
                max_value = opp.Amount;
            }
        }
        return res;
    }

    public static List<Integer> getDigits(Integer intNumber){
        List<Integer> result = new List<Integer>();
        Integer remainingNumber = intNumber;
        if (intNumber < 0) {
            remainingNumber = -intNumber;
        } else if (intNumber == 0) {
            result.add(0);
        }
        Integer numDigits = result.size();
        while (remainingNumber > 0) {
            if (numDigits == 0) {
                result.add(Math.mod(remainingNumber, 10));
            }
            else {
                result.add(0, Math.mod(remainingNumber, 10));
            }
            remainingNumber /= 10;
            numDigits++;
        }
        return result;
    }

    public class IntegerStackImpl {
        public List<Integer> container {get; private set; }

        public IntegerStackImpl(){
            container = new List<Integer>();
        }

        public void push(Integer value) {
            container.add(value);
        }

        public Integer pop(){
            if (container.size() > 0){
                return container.remove(container.size() - 1);
            }
            else {
                return null;
            }
        }
        public Integer size(){
            return container.size();
        }
    }

    public class IntegerQueueImpl {
        public List<Integer> container {get; private set; }

        public IntegerQueueImpl(){
            container = new List<Integer>();
        }

        public void push(Integer value) {
            if (container.size() > 0) {
                container.add(0, value);
            }
            else {
                container.add(value);
            }
        }

        public Integer shift() {
            if (container.size() > 0){
                return container.remove(container.size() - 1);
            }
            else {
                return null;
            }
        }
        public Integer size(){
            return container.size();
        }
    }

    public static void Test1(){
        // Practical task 1
        List<Integer> randoms = new List<Integer>();
        Integer n = 10;
        for (Integer i = 0; i < n; i++) {
            randoms.add((Integer)(2 + Math.random() * 4));
        }
        System.debug('Randoms: ' + randoms);
        System.debug('Unique randoms: ' + getUniques(randoms));
    }

    public static void Test2(){
        // Practical Task 2
        List<Contact> allContacts = [SELECT Id, Name FROM Contact];
        String lookupName = 'Rose Gonzalez';
        System.Debug('Found contact by name: ' + getContactByName(allContacts, lookupName));

//        //SOQL debug section
//        List<String> allContactNames = new List<String>();
//        for (Contact c:allContacts) allContactNames.add(c.Name);
//        System.debug('Number of contacts: ' + allContacts.size());
//        System.debug('All contact names: ' + allContactNames);
    }

    public static void Test3() {
        // Practical Task 3
        List<Opportunity> allOpportunities = [SELECT Id, Name, Amount FROM Opportunity];
        System.debug('Max amount opportunity: ' + getMaxAmountOpportunity(allOpportunities));
//        //SOQL debug section
//        List<Decimal> allOpportunityAmounts = new List<Decimal>();  // just for debug
//        for (Opportunity o:allOpportunities) allOpportunityAmounts.add(o.Amount);
//        System.debug('Number of opportunities: ' + allOpportunities.size());
//        System.debug('All opportunity amounts: ' + allOpportunityAmounts);
    }

    public static void Test4() {
        Integer intNumber = 123458392;
        System.debug('Number: ' + intNumber);
        System.debug('Number\'s digits: ' + getDigits(intNumber));
    }

    public static void Test5() {
        List<Integer> integers = new List<Integer>{1, 2, 3, 4, 5};
        IntegerStackImpl stack = new IntegerStackImpl();
        for (Integer i:integers) {
            System.debug('Pushing ' + i);
            stack.push(i);
        }
        System.debug('Full stack: ' + stack.container);
        while (stack.size() > 0) {
            System.debug('Popping ' + stack.pop());
        }
    }

    public static void Test6() {
        List<Integer> integers = new List<Integer>{1, 2, 3, 4, 5};
        IntegerQueueImpl queue = new IntegerQueueImpl();
        for (Integer i:integers) {
            System.debug('Queueing ' + i);
            queue.push(i);
        }
        System.debug('Full queue: ' + queue.container);
        while (queue.size() > 0) {
            System.debug('Leaving queue ' + queue.shift());
        }
    }

    public static void TestAll() {
        Test1();
        Test2();
        Test3();
        Test4();
        Test5();
        Test6();
    }
}