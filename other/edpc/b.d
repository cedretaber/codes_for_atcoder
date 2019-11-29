import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] HS, TABLE;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    foreach (i, h; readln.split.to!(long[])) HS[i] = h;

    foreach_reverse (i; 0..N) {
        if (i == N-1) continue;
        auto c = long.max;
        foreach (j; i+1..i+1+K) {
            if (j == N) break;
            c = min(c, TABLE[j] + abs(HS[i] - HS[j]));
        }
        TABLE[i] = c;
    }

    writeln(TABLE[0]);
}