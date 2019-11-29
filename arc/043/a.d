import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nab = readln.split.to!(long[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];

    long min_s = long.max, max_s = -1, sum_s;
    foreach (_; 0..N) {
        auto S = readln.chomp.to!long;
        min_s = min(min_s, S);
        max_s = max(max_s, S);
        sum_s += S;
    }

    auto d = max_s - min_s;
    double P;
    if (d == 0) {
        if (B != 0) {
            writeln(-1);
            return;
        } else {
            P = 1;
        }
    } else {
        P = B.to!double / d.to!double;
    }
    auto mean = sum_s.to!double / N * P;
    auto Q = A - mean;

    writefln("%.010f %.010f", P, Q);
}