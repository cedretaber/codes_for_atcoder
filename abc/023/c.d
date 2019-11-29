import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "r", int, "c");

P[10^^5] PP;
int[10^^5] RS, CS;

void main()
{
    auto rck = readln.split.to!(int[]);
    auto R = rck[0];
    auto C = rck[1];
    auto K = rck[2];

    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto rc = readln.split.to!(int[]);
        auto r = rc[0]-1;
        auto c = rc[1]-1;
        ++RS[r];
        ++CS[c];
        PP[i] = P(r, c);
    }

    int[int] rmemo;
    foreach (r; RS[0..R]) ++rmemo[r];

    long r;
    foreach (c; CS[0..C]) {
        auto rq = K - c;
        if (rq in rmemo) r += rmemo[rq];
    }
    foreach (p; PP[0..N]) {
        auto s = RS[p.r] + CS[p.c];
        if (s == K) --r;
        if (s == K+1) ++r;
    }

    writeln(r);
}