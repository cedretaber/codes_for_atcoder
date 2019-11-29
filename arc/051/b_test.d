import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int counter = 0;
int gcd(int a, int b) {
    if (b == 0) return a;
    counter++;
    return gcd(b, a%b);
}

void main() {
    auto ab = readln.split.to!(int[]);
    auto a = ab[0];
    auto b = ab[1];
    gcd(a, b);
    writeln(counter);
}