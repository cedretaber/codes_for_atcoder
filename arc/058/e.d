import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

long[uint][40] MEMO;

void main()
{
    auto nxyz = readln.split.to!(int[]);
    auto N = nxyz[0];
    auto X = nxyz[1];
    auto Y = nxyz[2];
    auto Z = nxyz[3];

    int[17] pv;
    int[3] xyz = [X, Y, Z];
    long solve(int i, uint s) {
        if (i == N) return 1;
        if (s in MEMO[i]) return MEMO[i][s];
        int j = 1;
        auto t = s;
        while (t) {
            int x = 1;
            while ((t&1) == 0) {
                ++x;
                t>>=1;
            }
            t>>=1;
            pv[j++] = x;
        }
        long r;
        foreach (x; 1..11) {
            pv[0] = x;
            int k = 0, l = 2, m = 0;
            while (k < j && l >= 0) {
                m += pv[k++];
                if (m == xyz[l]) {
                    m = 0;
                    --l;
                } else if (m > xyz[l]) {
                    break;
                }
            }
            if (l >= 0) r = (r + solve(i+1, (s<<x | 1<<(x-1)) & ((1<<16)-1))) % P;
        }
        return MEMO[i][s] = r; 
    }

    long r = 1;
    foreach (_; 0..N) {
        r = (r * 10) % P;
    }
    r = r - solve(0, 0);
    if (r < 0) r += P;
    writeln(r);
}