import java.io.File;
import java.io.FileReader;

public class Program {

   public static void main(String args[]) {
      File file = new File("X://fileDoesNotExist.txt");
      FileReader fr = new FileReader(file);
   }
}