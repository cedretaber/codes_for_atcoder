import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.bigint, std.container;

alias X = Tuple!(long, "a", long, "b");
alias E = Tuple!(int, "to", long, "s");

X[10^^5] XS;
E[][10^^5] G;
bool[10^^5] F;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 0..M) {
        auto uvs = readln.split.to!(int[]);
        auto u = uvs[0]-1;
        auto v = uvs[1]-1;
        auto s = uvs[2].to!long;
        G[u] ~= E(v, s);
        G[v] ~= E(u, s);
    }

    long[] rs;
    XS[0] = X(1, 0);
    auto ss = [0];
    F[0] = true;
    while (!ss.empty) {
        auto h = ss[0];
        auto a = XS[h].a;
        auto b = XS[h].b;
        ss = ss[1..$];
        foreach (n; G[h]) {
            if (F[n.to]) {
                auto xn = XS[n.to];
                auto aa = a + xn.a;
                auto bb = n.s - b - xn.b;
                if ((aa == 0 && bb != 0) || (aa != 0 && bb % aa != 0)) {
                    rs ~= -1;
                } else if (aa != 0 && bb % aa == 0) {
                    rs ~= bb / aa;
                }
            } else {
                F[n.to] = true;
                XS[n.to] = X(-a, n.s - b);
                ss ~= n.to;
            }
        }
    }
    long r = -1;
    if (!rs.empty) {
        auto rr = rs[0];
        if (rr == -1) {
            writeln(0);
            return;
        }
        foreach (rx; rs) {
            if (rx < 0 || rr != rx) {
                writeln(0);
                return;
            }
        }
        r = rr;
    }
    auto max_r = long.max, min_r = 1L;
    foreach (x; XS[0..N]) {
        if (x.a > 0 && x.b < 0) {
            min_r = max(min_r, -x.b / x.a + 1);
        } else if (x.a < 0 && x.b > 0) {
            max_r = min(max_r, x.b / -x.a - 1);
        } else if (x.a < 0 && x.b < 0) {
            writeln(0);
            return;
        }
    }
    if (min_r <= max_r) {
        if (r > 0) {
            writeln(min_r <= r && r <= max_r ? 1 : 0);
        } else {
            writeln(max_r - min_r + 1);
        }
    } else {
        writeln(0);
    }
}