import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias TD = Tuple!(int, "t", long, "d");

TD[10^^5] SS;
int[10^^5+1] MEMO;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    foreach (i; 0..N) {
        auto td = readln.split.to!(int[]);
        SS[i] = TD(td[0], td[1]);
    }

    sort!"a.d > b.d"(SS[0..N]);
    long max_d, bns;
    foreach (i; 0..K) {
        max_d += SS[i].d;
        auto t = SS[i].t;
        if (!MEMO[t]) ++bns;
        ++MEMO[t];
    }
    int i = K-1;
    long ret = max_d + bns^^2;
ml:
    foreach (j; K..N) {
        auto it = SS[i].t;
        while (MEMO[it] <= 1) {
            if (--i < 0) break ml;
            it = SS[i].t;
        }
        auto jt = SS[j].t;
        if (MEMO[jt]) continue;
        max_d = max_d - SS[i].d + SS[j].d;
        ++bns;
        ret = max(ret, max_d + bns^^2);
        --MEMO[it];
        ++MEMO[jt];
        --i;
    }

    writeln(ret);
}