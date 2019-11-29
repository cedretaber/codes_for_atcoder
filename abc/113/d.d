import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[100][8] DP;

long P = 1_000_000_007;

void main()
{

    foreach (ref h; DP) foreach (ref e; h) e = -1;

    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];

    long[] BS;
    BS.length = W;
    foreach (s; 0..2^^(W-1)) {
        bool prev, ok = true;
        foreach (i; 0..W-1) {
            auto c = (s & (1<<i)) > 0;
            if (prev && c) {
                ok = false;
                break;
            }
            prev = c;
        }
        if (!ok) continue;
        ++BS[0];
        foreach (i; 0..W-1) {
            if (s & (1<<i)) ++BS[i+1];
        }
    }

    long solve(int w, int h) {
        if (h == H) return w == K-1 ? 1 : 0;
        if (DP[w][h] != -1) return DP[w][h];

        auto r = solve(w, h+1) * (BS[0] - (w > 0 ? BS[w] : 0) - (w < W-1 ? BS[w+1] : 0));
        if (w > 0) r += solve(w-1, h+1) * BS[w];
        if (w < W-1) r += solve(w+1, h+1) * BS[w+1];
        return DP[w][h] = r % P;
    }

    writeln(solve(0, 0));
}