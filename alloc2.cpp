/*
 * File: alloc2.cpp
 */
#include <stdlib.h>

int main() {
	char *a;

	a = (char *) malloc(1);
	delete a;
	return 0;
}
