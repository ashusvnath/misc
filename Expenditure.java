import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Expenditure {
  static float median(int[] a, int d){
    int idx = d/2;
    int count = 0;
    int i = 0;
    int j = -1;
    while(i < 200 && count + a[i] < idx) {
      count += a[i];
      if(a[i] != 0) j = i;
      i++;
    }
    int k = idx - count;
    if(a[i] == k && a[i] == 1){
      return (d%2 == 0) ? (i + j)/2.0f : i;
    }
    return i;
  }

  static int activityNotifications(int[] expenditure, int n, int d) {
    int[] history = new int[202];
    for(int i = 0 ; i < d ; i++){
      history[expenditure[i]]++;
    }
    int old = 201;
    int count = 0, v;
    float m;
    for(int i = d; i < n ; i++){
      history[old]--;
      v = expenditure[i];
      history[v]++;
      m = median(history, d);
      if(v >= 2*m)
        count++;
      old = expenditure[i-d];
    }
    return count - 1;
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
