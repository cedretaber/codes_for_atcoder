import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    int cnt;
    foreach (n; 1..N+1) {
        if (n % 2 == 0) continue;
        int y;
        foreach (x; 1..n+1) {
            if (n % x == 0) ++y;
        }
        if (y == 8) ++cnt;
    }
    writeln(cnt);
}