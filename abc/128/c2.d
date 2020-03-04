import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] ss;
    ss.length = M;
    foreach (i; 0..M) {
        auto ks = readln.split.to!(int[]);
        foreach (s; ks[1..$]) ss[i] ~= s-1;
    }
    auto ps = readln.split.to!(int[]);

    int r;
    foreach (x; 0..1<<N) {
        foreach (i; 0..M) {
            int c;
            foreach (s; ss[i]) if (x & (1<<s)) ++c;
            if (c%2 != ps[i]) goto ng;
        }
        ++r;
        ng:
    }

    writeln(r);
}