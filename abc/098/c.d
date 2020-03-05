import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto es = new int[](N);
    auto ws = new int[](N);
    foreach (i; 0..N) {
        if (i > 0) ws[i] += ws[i-1];
        if (S[i] == 'W') ws[i] += 1;
    }
    foreach_reverse (i; 0..N) {
        if (i < N-1) es[i] += es[i+1];
        if (S[i] == 'E') es[i] += 1;
    }

    int r = N;
    foreach (i; 0..N) {
        int rr;
        if (i > 0) rr += ws[i-1];
        if (i < N-1) rr += es[i+1];
        r = min(r, rr);
    }
    writeln(r);
}