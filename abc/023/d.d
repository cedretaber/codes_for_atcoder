import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias HS = Tuple!(long, "h", long, "s");

HS[10^^5] HSS;
int[10^^5] SUM;

void main()
{
    auto N = readln.chomp.to!long;
    long p_min = 0, p_max;
    foreach (i; 0..N) {
        auto hs = readln.split.to!(long[]);
        HSS[i] = HS(hs[0], hs[1]);
        p_max = max(p_max, hs[0] + hs[1] * N);
    }

    while (p_min+1 != p_max) {
        foreach (ref n; SUM[0..N]) n = 0;
        auto p_mid = (p_min + p_max) / 2L;
        int t;
        foreach (hs; HSS[0..N]) {
            auto d = (p_mid - hs.h);
            if (d < 0) {
                p_min = p_mid;
                goto next;
            }
            d /= hs.s;
            if (d >= N) continue;
            ++SUM[d];
        }
        foreach (i, s; SUM[0..N]) {
            t += s;
            if (t > i.to!long + 1) {
                p_min = p_mid;
                goto next;
            }
        }
        p_max = p_mid;
        next:
    }

    writeln(p_max);
}