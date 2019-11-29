import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];
    char[][] CK;
    CK.length = H;
    auto HK = new int[](H);
    foreach (i; 0..H) {
        CK[i] = readln.chomp.to!(char[]);
        int k;
        foreach (c; CK[i]) if (c == '#') ++k;
        HK[i] = k;
    }
    auto RR = new int[][](H, W);
    int start = -1;
    int n;
    foreach (i; 0..H) {
        if (start == -1) {
            if (HK[i] == 0) continue;
            start = i;
        }
        if (HK[i] == 0) {
            foreach (j; 0..W) {
                RR[i][j] = RR[i-1][j];
            }
        } else if (HK[i] == 1) {
            ++n;
            foreach (j; 0..W) RR[i][j] = n;
        } else {
            ++n;
            bool skip;
            foreach (j; 0..W) {
                if (CK[i][j] == '#') {
                    if (skip) ++n;
                    skip = true;
                }
                RR[i][j] = n;
            }
        }
    }
    foreach_reverse (i; 0..start) foreach (j; 0..W) RR[i][j] = RR[i+1][j];

    foreach (r; RR) writeln(r.to!(string[]).join(" "));
}