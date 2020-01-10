import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = readln.split.to!(long[]);

    auto af = as[0];
    int x;
    while (af%2 == 0) {
        af /= 2;
        ++x;
    }
    foreach (a; as[1..$]) {
        int y;
        while (a%2 == 0) {
            a /= 2;
            ++y;
        }
        if (x != y) {
            writeln(0);
            return;
        }
    }

    auto d = as[0] / 2;
    foreach (a; as[1..$]) {
        d = d / gcd(d, a/2) * a/2;
        if (d > M) {
            writeln(0);
            return;
        }
    }
    writeln(M/d - M/(d*2));
}