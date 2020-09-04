import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto np = readln.split.to!(long[]);
    auto N = np[0];
    auto P = np[1];
    auto S = readln.chomp;

    if (P == 2 || P == 5) {
        long r;
        foreach (i, c; S) if ((c-'0')%P == 0) r += i.to!long + 1;
        writeln(r);
        return;
    }

    auto DP = new long[](P);
    DP[0] = 1;
    long s, d = 1, r;
    foreach_reverse (c; S) {
        (s += (c - '0').to!long * d) %= P;
        r += DP[s];
        ++DP[s];
        (d *= 10) %= P;
    }
    writeln(r);
}