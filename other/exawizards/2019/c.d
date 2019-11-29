import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias M = Tuple!(int, "t", int, "d");

int[10^^5*2] TS;
M[10^^5*2] QS;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    foreach (int i, c; readln.chomp.to!(char[])) {
        TS[i] = c-65;
    }
    foreach (i; 0..Q) {
        auto td = readln.chomp.to!(char[]);
        QS[i] = M(td[0] - 65, td[2] == 'L' ? -1 : 1);
    }
    int r;
    int i;
    foreach_reverse (q; QS) {
        if (i < N && q.t == TS[max(i, 0)] && q.d < 0) {
            if (i < 0) i = 1;
            else ++i;
        }
        if (i > 0 && i-1 < N && q.t == TS[i-1] && q.d > 0) --i;
    }
    r += max(i, 0);
    i = N;
    foreach_reverse (q; QS) {
        if (i > 0 && q.t == TS[min(i-1, N-1)] && q.d > 0) {
            if (i > N) i = N-1;
            else --i;
        }
        if (i > 0 && i < N && q.t == TS[i] && q.d < 0) ++i;
    }
    r += (N-min(i, N));
    writeln(N-r);
}