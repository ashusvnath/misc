import java.io.*;
import java.util.*;

public class non_divisible {
  static int maximalSubset(int n, int k, int[] a){
    int result = 0;
    Map<Integer, Set<Integer>> partitions = new HashMap<Integer, Set<Integer>>();
    Set<Integer> partition;
    for(int i = 0; i < n ; i++) {
      int rem = a[i] % k;
      partition = partitions.getOrDefault(rem, new HashSet<Integer>());
      partition.add(a[i]);
      partitions.put(rem, partition);
    }

    Set<Integer> addedPartitions = new HashSet<Integer>();
    for(Integer i : partitions.keySet()){
      if(i == 0 && partitions.get(i).size() > 2){
        continue;
      }
      if(!addedPartitions.contains(i) &&
         (partitions.get(i).size() > partitions.getOrDefault(k - i, Collections.EMPTY_SET).size()) &&
         (i != k - i))
        addedPartitions.add(i);
      System.err.print(String.format("(%5d, %5d),", i, partitions.get(i).size()));
    }
    System.err.print("\nAdding partitions ");
    for(Integer i : addedPartitions){
      System.err.print(i + " ");
      result += partitions.get(i).size();
    }
    System.err.println("");
    return result;
  }

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    int n, k;
    n = sc.nextInt();
    k = sc.nextInt();
    int[] a = new int[n];
    for(int i = 0; i < n ; i++){
      a[i] = sc.nextInt();
    }
    System.out.println(k == 1 ? 1 : maximalSubset(n,k,a));
  }
}