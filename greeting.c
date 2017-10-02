#include <stdio.h>

int main(int argc, char* argv[]){
  char name[100];
  printf("Please enter your name: ");
  scanf("%s", name);
  printf("Hi, %s. Welcome to java training", name);
  return 0;
}