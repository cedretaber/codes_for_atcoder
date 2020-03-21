import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 1000000007;

void main()
{
    auto N = readln.chomp.to!int;
    int a, b, c;
    long r = 1;
    foreach (x; readln.split.to!(int[])) {
        if (x == a && a == b && a == c) {
            r = (r * 3) % P;
            ++a;
        } else if (x == a && a == b) {
            r = (r * 2) % P;
            ++a;
        } else if (x == b && b == c) {
            r = (r * 2) % P;
            ++b;
        } else if (x == a) {
            ++a;
        } else if (x == b) {
            ++b;
        } else if (x == c) {
            ++c;
        } else {
            writeln(0);
            return;
        }
    }
    writeln(r);
}