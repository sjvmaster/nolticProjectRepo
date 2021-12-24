/**
 * Created by Ivan.Sokolov on 04.11.2021.
 */

public class Palindrome {
    public Boolean isPalindrome(Integer toCheck) {
        String toCheckStr = String.valueOf(toCheck);
        String toCheckStrReversed = toCheckStr.reverse();
        return toCheckStr == toCheckStrReversed;
    }

    public Boolean isPalindrome(String toCheckStr) {
        return toCheckStr == toCheckStr.reverse();
    }

    public Boolean isPalindromeInt(Integer toCheck){
        Integer result = 0;
        Integer tmpCheck = toCheck;
        Integer reminder;
        while (tmpCheck > 0) {

            reminder = Math.mod(tmpCheck, 10);
            tmpCheck = tmpCheck / 10;
            result *= 10;
            result += reminder;
        }
        return result == toCheck;
    }
}