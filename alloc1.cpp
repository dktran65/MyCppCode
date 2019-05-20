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

void array_boundery_violation()
{
	int aBV[3] = {1,2,3};

	aBV[4]= 5;
}


void null_pointer_deference_general_must()
{
	int *iPtr = NULL;
	*iPtr = 2;

}
