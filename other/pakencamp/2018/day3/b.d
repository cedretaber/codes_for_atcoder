import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = new long[](N);
    foreach (i; 0..N) {
        as[i] = readln.chomp.to!long;
    }
    long r, cnt;
    foreach (i, a; as) {
        r += a;
        if (r <= 2018) ++cnt;
    }
    writeln(cnt);
}