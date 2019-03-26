/*
 * File: alloc1.cpp
 */
#include <stdlib.h>

int main() {
	char *a;

	a = new char;
	free(a);
	return 0;
}
