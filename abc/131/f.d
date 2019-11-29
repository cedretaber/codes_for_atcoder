import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5+1] X, Y;
bool[10^^5+1] XF, YF;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(int[]);
        X[xy[0]] ~= xy[1];
        Y[xy[1]] ~= xy[0];
    }

    long r;
    foreach (i; 1..10^^5+1) {
        if (XF[i]) continue;
        XF[i] = true;
        auto ss = [[1, i]];
        long xp = 1, yp, e;
        while (!ss.empty) {
            auto h = ss[0];
            auto x = h[0];
            auto n = h[1];
            ss = ss[1..$];
            foreach (nxt; (x ? X[n] : Y[n])) {
                ++e;
                if (x) {
                    if (YF[nxt]) continue;
                    YF[nxt] = true;
                    ss ~= [0, nxt];
                    ++yp;
                } else {
                    if (XF[nxt]) continue;
                    XF[nxt] = true;
                    ss ~= [1, nxt];
                    ++xp;
                }
            }
        }
        r += xp * yp - e/2;
    }
    writeln(r);
}