import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto S = readln.chomp.to!(wchar[]);
    auto T = readln.chomp.to!(wchar[]);

    auto lcm = N * M / gcd(N, M);
    auto n = lcm / N;
    auto m = lcm / M;

    long i, j;
    for (;;) {
        if (i >= N || j >= M) break;
        if (S[i] != T[j]) {
            writeln("-1");
            return;
        }
        i += m;
        j += n;
    }
    writeln(lcm);
}