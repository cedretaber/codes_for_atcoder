import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 1000000007L;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto len = S.length;
    string[] ts;
    foreach (_; 0..N) ts ~= readln.chomp;

    auto DP = new long[](len+1);
    DP[0] = 1;
    foreach (i; 0..len) {
        foreach (t; ts) {
            auto j = t.length;
            if (i+j > len || S[i..i+j] != t) continue;
            (DP[i+j] += DP[i]) %= P;
        }
    }
    writeln(DP[len]);
}