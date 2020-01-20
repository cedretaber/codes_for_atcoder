import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto memo = new long[][](10, 10);
    foreach (n; 1..N+1) {
        auto y = n%10;
        int x;
        while (n) {
            x = n;
            n /= 10;
        }
        ++memo[x][y];
    }

    long r;
    foreach (i; 1..10) {
        foreach (j; 1..10) {
            r += memo[i][j] * memo[j][i];
        }
    }
    writeln(r);
}