/**
 * Created by Ivan.Sokolov on 09.11.2021.
 */

public with sharing class SortingCourses {
    public static List<Integer> sort(List<Integer> numbers){
        if (numbers.size() <= 1) {
            return numbers;
        } else {
            List<Integer> left = new List<Integer>();
            List<Integer> right = new List<Integer>();
            Integer corner = numbers.remove(numbers.size() / 2);
            for(Integer num: numbers) {
                if (corner > num) {
                    left.add(num);
                }
                else {
                    right.add(num);
                }
            }
            List<Integer> sorted = sort(left);
            sorted.add(corner);
            sorted.addAll(sort(right));
            return sorted;
        }

    }
}