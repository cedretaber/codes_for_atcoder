import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp;
    auto len = N.length.to!int;
    auto D = readln.chomp.to!int;

    auto DP = new long[][](len, D+1);
    foreach (i; max(0, len-7)..len) {
        auto n = N[i..$].to!int;
        if (n > D) continue;
        DP[i][n] = 1;
    }
    foreach_reverse (i; 0..len-1) {
        foreach (j; i+1..min(len, i+8)) {
            auto n = N[i..j].to!int;
            if (n > D) continue;
            foreach (d; 0..D+1) {
                if (d < n) continue;
                DP[i][d] = (DP[i][d] + DP[j][d-n]) % P;
            }
        }
    }
    long r;
    foreach (d; 0..D+1) r = (r + DP[0][d]) % P;
    writeln(r);
}