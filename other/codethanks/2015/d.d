import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ss = new int[](N);
    foreach (i; 0..N) ss[i] = readln.chomp.to!int;
    auto ps = new bool[][](N, N);
    int sum_p;
    foreach (i; 0..N) {
        sum_p += ss[i];
        ps[i][i] = true;
    }
    auto M = readln.chomp.to!int;
    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0];
        auto b = abc[1]-1;
        auto c = abc[2]-1;
        if (a == 0) {
            ps[b][c] = true;
        } else {
            if (ps[b][c]) {
                writefln("%d %d", ss[c], ss[c]);
            } else {
                int min_p, max_p;
                foreach (i; 0..N) if (i != c) {
                    if (ps[b][i]) {
                        min_p += ss[i];
                        max_p += ss[i];
                    } else {
                        max_p += 100;
                    }
                }
                writefln("%d %d", max(0, sum_p - max_p), min(100, sum_p - min_p));
            }
        }
    }
}