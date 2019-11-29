import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Q = Tuple!(size_t, "i", int, "a");
Q[2*10^^5] QS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    foreach (i, a; readln.split.to!(int[])) QS[i] = Q(i, a);
    sort!"a.a > b.a"(QS[0..N]);
    foreach (q; QS[0..N]) if (q.a < K) {
        writeln(q.i+1);
        return;
    }
    writeln(-1);
}