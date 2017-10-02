import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Expenditure {
  interface Median {
    float of(List<Integer> l);
  }

  static int activityNotifications(int[] expenditure, int n, int d) {
    List<Integer> history = new ArrayList<Integer>();
    for(Integer i : Arrays.copyOfRange(expenditure, 0, d-1)){
      history.add(i);
    }
    int old = -1;
    int half_d = d/2;
    int count = 0;
    Median median = (d % 2 == 0) ?
      (l ->  (l.get(half_d-1) + l.get(half_d))/2.0f) :
      (l -> l.get(half_d)*1.0f);
    Collections.sort(history);
    int k = 0;
    for(int i = d; i < n ; i++){
      history.remove(new Integer(old));
      while(history.get(k) < expenditure[i]) k++;
      history.add(k, expenditure[i]);
      float m = median.of(history);
      if(expenditure[i] >= 2*m)
        count++;
      old = expenditure[i-d];
    }
    return count;
  }

  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    int n = in.nextInt();
    int d = in.nextInt();
    int[] expenditure = new int[n];
    for(int expenditure_i = 0; expenditure_i < n; expenditure_i++){
      expenditure[expenditure_i] = in.nextInt();
    }
    int result = activityNotifications(expenditure, n, d);
    System.out.println(result);
    in.close();
  }
}
