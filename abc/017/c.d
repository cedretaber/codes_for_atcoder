import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias D = Tuple!(int, "l", int, "r", long, "s");
D[10^^5] DSL, DSR;
long[10^^5] CSL, CSR;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 0..N) {
        auto lrs = readln.split.to!(int[]);
        auto d = D(lrs[0], lrs[1], lrs[2]);
        DSL[i] = d;
        DSR[i] = d;
    }
    sort!"a.l < b.l"(DSL[0..N]);
    sort!"a.r < b.r"(DSR[0..N]);
    foreach_reverse (i; 0..N) {
        if (i == N-1) {
            CSL[i] = DSL[i].s;
        } else {
            CSL[i] = CSL[i+1] + DSL[i].s;
        }
    }
    foreach (i; 0..N) {
        if (i == 0) {
            CSR[i] = DSR[i].s;
        } else {
            CSR[i] = CSR[i-1] + DSR[i].s;
        }
    }
    long ret;
    size_t l, r;
    foreach (i; 1..M+1) {
        while (l < N-1 && DSL[l].l <= i) ++l;
        while (r < N-1 && DSR[r+1].r < i) ++r;
        long rr;
        if (DSR[r].r < i) rr += CSR[r];
        if (DSL[l].l > i) rr += CSL[l];
        ret = max(ret, rr); 
    }
    writeln(ret);
}