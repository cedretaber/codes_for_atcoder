import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = readln.split.to!(long[]);
    auto x = as[0]/2;
    int k;
    while (x % 2 == 0) {
        ++k;
        x /= 2;
    }
    x = as[0]/2;
    foreach (a; as[1..$]) {
        a /= 2;
        x = x * a / gcd(x, a);
        if (x <= 0) {
            writeln(0);
            return;
        }
        int kk;
        while (a%2 == 0) {
            ++kk;
            a /= 2;
        } 
        if (k != kk) {
            writeln(0);
            return;
        }
    }
    writeln((M/x+1)/2);
}