/*
 * File: leak.cpp
 */
#include <string.h>

union S1 {
	char *cp;
	S1() { cp=new char[10]; }
	S1(char *p) {
		cp=new char[10];
		strcpy(cp,p);
	}
	S1(S1 &s) {
		cp=new char[10];
		strcpy(cp,s.cp);
	}
	void mf(char *p) { strcpy(cp,p); }
};
void foo() {
	S1 s1,s2("Hello "),s3=s2;
	s1.mf("SADF");
	s3.mf("World");
}
int main() {
	foo();
	return(0);
}
