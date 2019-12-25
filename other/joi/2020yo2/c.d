import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto MEMO = new int[](N+1);
    int solve(int n) {
        if (n > N || MEMO[n] == 2) return 2;
        if (MEMO[n] == 1) return 1;
        auto m = n;
        auto x = n;
        while (m) {
            x += m % 10;
            m /= 10;
        }
        return MEMO[n] = solve(x);
    }
    MEMO[N] = 1;
    foreach (i; 1..N) solve(i);
    int r;
    foreach (m; MEMO) if (m == 1) ++r;
    writeln(r);
}