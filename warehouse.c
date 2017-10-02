#include <stdio.h>
#include <stdlib.h>

typedef struct {
	double totalDimensions;
	double weightInKiloGrams;
} ITEM;

typedef struct {
	double x;
	double y;
} POSITION;

int main(int argc, char * argv[]){
	ITEM *item = (ITEM *) malloc(sizeof(ITEM));
	item->totalDimensions = 1000.5;
	item->weightInKiloGrams = 120.4;
	POSITION *position = (POSITION *)item;
	printf("Position of item is %lf %lf\n", position->x, position->y);
	return 0;
}




