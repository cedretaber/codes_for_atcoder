import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[][300] G;
bool[300] F;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto n = nmk[0];
    auto m = nmk[1];
    auto k = nmk[2];
    auto cs = readln.split.join.to!(dchar[]);

    foreach (_; 0..m) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        G[a] ~= b;
        G[b] ~= a;
    }

    dchar[][] rr;
    foreach (i; 0..n) {
        if (F[i]) continue;
        F[i] = true;
        dchar[] r;
        auto ss = [i];
        while (!ss.empty) {
            auto h = ss[0];
            ss = ss[1..$];
            r ~= cs[h];
            foreach (g; G[h]) if (!F[g]) {
                F[g] = true;
                ss ~= g;
            }
        }
        if (r.length >= k) {
            sort(r);
            rr ~= r[0..k];
        }
    }
    if (rr.empty) {
        writeln(-1);
    } else {
        sort(rr);
        writeln(rr[0]);
    }
}