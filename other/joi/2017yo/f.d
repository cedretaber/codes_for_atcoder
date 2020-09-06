import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
 
alias P = Tuple!(int, "to", int, "d");
alias S = Tuple!(int, "i", int, "d", int, "r", int, "t");
 
void main()
{
    auto nmx = readln.split.to!(int[]);
    auto N = nmx[0];
    auto M = nmx[1];
    auto X = nmx[2];
 
    int[] RS;
    foreach (_; 0..N) RS ~= readln.chomp.to!int;
    auto G = new P[][N];
    foreach (_; 0..M) {
        auto abd = readln.split.to!(int[]);
        auto A = abd[0]-1;
        auto B = abd[1]-1;
        auto D = abd[2];
        G[A] ~= P(B, D);
        G[B] ~= P(A, D);
    }
 
    auto DP = new int[][][](N, X+1, 2);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max/3;
    DP[0][X][0] = 0;
    auto Q = heapify!"a.d > b.d"([S(0, 0, 0, X)]);
    while (!Q.empty) {
        with (Q.front) {
            Q.popFront();
            foreach (n; G[i]) {
                auto tt = max(0, t - n.d);
                if (r == 0 && RS[n.to] == 2 && tt > 0) continue;
                if (r == 1 && RS[n.to] == 0 && tt > 0) continue;
                auto rr = r;
                if (RS[n.to] == 0) {
                    rr = 0;
                    tt = X;
                } else if (RS[n.to] == 2) {
                    rr = 1;
                    tt = X;
                }
                if (DP[n.to][tt][rr] <= d + n.d) continue;
                DP[n.to][tt][rr] = d + n.d;
                Q.insert(S(n.to, d + n.d, rr, tt));
            }
        }
    }
    auto r = int.max;
    foreach (d; 0..X+1) {
        r = min(r, DP[N-1][d][0]);
        r = min(r, DP[N-1][d][1]);
    }
    writeln(r);
}