import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nc = readln.split.to!(int[]);
    long N = nc[0];
    auto C = nc[1];
    auto as = readln.split.to!(int[]);

    long[][] ps;
    ps.length = C;
    foreach (ref pp; ps) pp ~= -1;
    foreach (i, a; as) {
        ps[a-1] ~= i.to!long;
    }
    foreach (ref pp; ps) pp ~= N;
    foreach (ref pp; ps) {
        long n = N * (N+1) / 2;
        foreach (i; 1..pp.length) {
            auto l = pp[i] - pp[i-1] - 1;
            n -= l * (l+1) / 2;
        }
        writeln(n);
    }
}