import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias C = Tuple!(int, "i", long, "a");

void main()
{
    auto N = readln.chomp.to!int;
    long[] AS;
    C[] cs;
    foreach (i, a; readln.split.to!(long[])) {
        AS ~= a;
        cs ~= C(i.to!int, a);
    }
    sort!"a.a > b.a"(cs);
    auto DP = new long[][](N+1, N+1);
    foreach (x; 0..N) {
        foreach (y; 0..N-x) {
            auto i = cs[x+y].i;
            auto A = cs[x+y].a;
            DP[x+1][y] = max(DP[x+1][y], DP[x][y] + abs(i - x) * A);
            DP[x][y+1] = max(DP[x][y+1], DP[x][y] + abs(i - (N-y-1)) * A);
        }
    }

    long r;
    foreach (x; 0..N+1) {
        auto y = N-x;
        r = max(r, DP[x][y]);
    }
    writeln(r);
}