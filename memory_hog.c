#include <stdlib.h>
#include <stdio.h>

typedef struct {
	double r[10000000];
	double g[10000000];
	double b[10000000];
	double a[10000000];
} FRAME;

int main(int argc, char *argv[]){
	FRAME *fp;
	int limit;
	limit = (argc > 0) ? atoi(argv[1]) : 10000;
	for(int i = 0; i < limit; i++){
		fp = (FRAME *)malloc(sizeof(FRAME));
		printf("Successfully allocated %p\n", fp);
		free(fp);
	}
	return 0;
}




