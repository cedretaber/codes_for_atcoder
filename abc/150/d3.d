import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    long x = 1;
    int c;
    foreach (a; readln.split.to!(long[])) {
        auto y = x / gcd(x, a/2) * (a/2);
        if (y < 0 || M < y) {
            writeln(0);
            return;
        }
        x = y;
        int d;
        while (a%2 == 0) {
            ++d;
            a /= 2;
        }
        if (c == 0) {
            c = d;
        } else if (c != d) {
            writeln(0);
            return;
        }
    }
    writeln((M - x) / (x*2) + 1);
}

/*


3 9 15 21 27 33 39 45
 5  15   25   35   45

lcm(6, 10) = 30

15 45


6 4

lcm(6, 4) = 12

2 6 10 14 18 22
3 9 15 21 27 33 39 45

4 8

2 6 10 14 18 22 26 30 34 
4 12 20 28 36

*/