import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];

    char[][] C;
    foreach (_; 0..H) C ~= readln.chomp.to!(char[]);
    int r = int.max;

    foreach (x; 0..1<<(H-1)) {
        auto N = popcnt(x)+1;
        int[] cs, ccs;
        cs.length = N;
        ccs.length = N;
        int rr;
        foreach (j; 0..W) {
            {
                int k;
                foreach (i; 0..H) {
                    if (C[i][j] == '1') ++ccs[k];
                    if (x & (1<<i)) ++k;
                }
            }
            foreach (k; 0..N) if (cs[k] + ccs[k] > K) {
                if (ccs[k] > K) goto ng;
                ++rr;
                cs[] = 0;
                break;
            }
            foreach (k; 0..N) cs[k] += ccs[k];
            ccs[] = 0;
        }
        r = min(r, rr + N-1);
        ng:
    }
    writeln(r);
}