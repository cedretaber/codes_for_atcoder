import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int N, M;
string[100] NS, MS;

void main()
{
    N = readln.chomp.to!int;
    foreach (i; 0..N) NS[i] = readln.chomp;
    M = readln.chomp.to!int;
    foreach (i; 0..M) MS[i] = readln.chomp;

    auto ns = NS[0..N];
    auto ms = MS[0..M];

    int max_p;
    foreach (s; ns) {
        int p;
        foreach (n; ns) if (n == s) ++p;
        foreach (m; ms) if (m == s) --p;
        max_p = max(max_p, p);
    }
    writeln(max_p);
}