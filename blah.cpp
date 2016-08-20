#include <iostream>
using namespace std;

int main()
{
	int T;
	cin>>T;
	for(int i=0; i<T; i++)
	{
		int A,B,N;
		cin>>A>>B>>N;
		int j=1, k=1;
		int a=0;
		for(int l=0; l<N; l++)
		{
			if(A*j < B*k)
				{a=A*j; j++;}
			else if(A*j > B*k)
				{a=B*k; k++;}
			else
				{a=A*j; j++; k++;}
		}
		cout<<a<<endl;
	}
	return 0;
}