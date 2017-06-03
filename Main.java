
class Generic<T1,T2> {
	public String foo(){
		return (new T1())	.getClass().toString() + (new T2()).getClass().toString();
	}
}

public class Main {
	public static void main(String[] args) {
		Generic<Int,String> object = new Generic<Int,String>();
		System.out.println(object.foo());
	}
}
