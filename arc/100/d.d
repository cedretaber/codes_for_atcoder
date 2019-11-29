import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long[2*10^^5] AS, SAS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i, e; readln.split.to!(long[])) {
        AS[i] = e;
        if (i) {
            SAS[i] = SAS[i-1] + e;
        } else {
            SAS[i] = e;
        }
    }
    auto SUM = SAS[N-1];

    size_t pi = 0, qi = 1, ri = 2;
    long P, Q, R, S, min_v = long.max;
    while (qi < N-2) {
        while (ri <= qi) ++ri;
        while (pi < qi-1 && abs(SAS[qi] - SAS[pi]*2) > abs(SAS[qi] - SAS[pi+1]*2)) ++pi;
        P = SAS[pi];
        Q = SAS[qi] - P;
        while (ri < N-2 && abs(SUM - SAS[ri] - (SAS[ri] - P - Q)) > abs(SUM - SAS[ri+1] - (SAS[ri+1] - P - Q))) ++ri;
        R = SAS[ri] - P - Q;
        S = SUM - P - Q - R;
        auto v = max(P, Q, R, S) - min(P, Q, R, S);
        min_v = min(min_v, v);
        ++qi;
    }
    writeln(min_v);
}