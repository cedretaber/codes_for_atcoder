import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[50][50][100][2] DP;

void main()
{
    auto rck = readln.split.to!(int[]);
    auto R = rck[0];
    auto C = rck[1];
    auto K = rck[2];
    char[][] MAP;
    MAP.length = R;
    int si, sj, gi, gj;
    foreach (i; 0..R) {
        MAP[i] = readln.chomp.to!(char[]);
        foreach (j, e; MAP[i]) {
            switch (e) {
                case 'S':
                    si = i;
                    sj = j.to!int;
                    break;
                case 'G':
                    gi = i;
                    gj = j.to!int;
                    break;
                default:
            }
        }
    }

    foreach (ref a; DP)
        foreach (ref b; a)
            foreach (ref c; b)
                foreach (ref d; c)
                    d = int.max;

    void solve(int c, int i, int j, int s, int e, bool[][] es) {
        foreach (d; [[1, 0], [-1, 0], [0, 1], [0, -1]]) {
            auto ii = i + d[0];
            auto jj = j + d[1];
            if (ii < 0 || ii >= R || jj < 0 || jj >= C) continue;
            if (MAP[ii][jj] == 'T') continue;
            auto ss = MAP[ii][jj] == 'C' ? 1 : s;
            auto ee = e;
            bool first;
            if (MAP[ii][jj] == 'E' && !es[ii][jj]) {
                if (e == 0) continue;
                first = true;
                es[ii][jj] = true;
                --ee;
            }
            if (DP[ss][ee][ii][jj] > c+1) {
                DP[ss][ee][ii][jj] = c+1;
                solve(c+1, ii, jj, ss, ee, es);
            }
            if (first) {
                es[ii][jj] = false;
            }
        }
    }
    solve(0, si, sj, 0, K, new bool[][](R, C));
    int r = int.max;
    foreach (k; 0..K+1) {
        r = min(r, DP[1][k][gi][gj]);
    }
    writeln(r == int.max ? -1 : r);
}