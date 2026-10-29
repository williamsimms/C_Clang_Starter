#include <stdio.h>

int main(int argc, char *argv[]) {
  constexpr int arrSize = 5;

  int numArr[arrSize] = {1, 2, 3, 4, 5};

  bool isTrue = true;

  printf("Is true: %s\n", isTrue ? "true" : "false");

  return 0;
}