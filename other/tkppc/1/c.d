import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto S = readln.chomp.to!int;
    auto ks = new long[](S+1);
    foreach (_; 0..N) {
        auto tk = readln.split.to!(long[]);
        ks[tk[0]] += tk[1];
    }
    int r;
    foreach (i; 0..S) {
        if (ks[i] >= M) ++r;
        ks[i+1] += ks[i];
    }
    writeln(r);
}