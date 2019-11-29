import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5+1] MEMO;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto lr = readln.split.to!(int[]);
        auto L = lr[0]-1;
        auto R = lr[1]-1;
        MEMO[L] += 1;
        MEMO[R+1] -= 1;
    }

    int c, r;
    foreach (i; 0..N) {
        c += MEMO[i];
        if (c == M) ++r;
    }
    writeln(r);
}