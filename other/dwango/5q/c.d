import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias M = Tuple!(int, "d", int, "c");

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto Q = readln.chomp.to!int;
    auto ks = readln.split.to!(int[]);

    int[] ds, cs;
    M[] ms;
    foreach (i; 0..N) {
        if (S[i] == 'D') {
            ds ~= i;
        } else if (S[i] == 'M') {
            if (!ds.empty) ms ~= M(ds.length.to!int-1, 0);
        }
    }
    size_t j = ms.length-1;
    foreach_reverse (i; 0..N) {
        if (S[i] == 'C') {
            cs ~= i;
        } else if (S[i] == 'M') {
            if (cs.empty) {
                ms = ms[0..$-1];
            } else {
                ms[j].c = cs.length.to!int-1;
                if (j == 0) break;
            }
            --j;
        }
    }

    foreach (k; ks) {
        long r;
        foreach (m; ms) {
            
        }
    }
}