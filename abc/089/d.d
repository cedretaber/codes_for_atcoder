import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias A = Tuple!(int, "i", int, "j");
alias LR = Tuple!(int, "i", int, "l", int, "r", long, "ret");

int H, W, D, Q;
A[300*300+1] AS;
LR[10^^5] QS;

void main()
{
    auto hwd = readln.split.to!(int[]);
    H = hwd[0];
    W = hwd[1];
    D = hwd[2];

    foreach (j; 0..H)
        foreach (i, e; readln.split.to!(int[]))
            AS[e] = A(i.to!int, j);

    Q = readln.chomp.to!int;
    foreach (i; 0..Q) {
        auto lr = readln.split.to!(int[]);
        QS[i] = LR(i, lr[0], lr[1], 0);
    }
    sort!"a.l == b.l ? a.r < b.r : a.l < b.l"(QS[0..Q]);
    LR[][] qss;
    int ll;
    auto ap = appender!(LR[]);
    foreach (q; QS[0..Q]) {
        if (q.l != ll) {
            ll = q.l;
            qss ~= ap.data;
            ap = appender!(LR[]);
        }
        ap.put(q);
    }
    qss ~= ap.data;
    qss = qss[1..$];

    auto ret = appender!(LR[]);
    foreach (qs; qss) {
        auto L = qs[0].l;
        auto x = L;
        long d;
        while (!qs.empty) {
            if (qs[0].r == x) {
                auto q = qs[0];
                q.ret = d;
                ret.put(q);
                qs = qs[1..$];
            } else {
                auto a = AS[x];
                x += D;
                auto ad = AS[x];
                d += abs(a.i - ad.i) + abs(a.j - ad.j);
            }
        }
    }
    auto ans = ret.data;
    sort!"a.i < b.i"(ans);
    foreach (q; ans) writeln(q.ret);
}