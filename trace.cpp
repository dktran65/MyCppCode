/*
 * File: trace.cpp
 */
int twice(int j) {
	return j*2;
}

class Object {
public:
	int i;
	Object() {
		i = 0;
	}
	Object(int j) {
		i = j;
	}
	operator int() { return twice(i); }
};

int main() {
	Object o;
	int i;

	i = o;
	return i;
}
