import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto G = new int[][N];
    auto RG = new int[][N];
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        RG[B] ~= A;
    }

    foreach (n; 0..N) {
        auto memo = new bool[](N);
        int[] walk(int i, int p) {
            foreach (j; RG[i]) if (j != p && memo[j]) return [];
            int[] js;
            foreach (j; G[i]) if (memo[j]) js ~= j;
            if (js.length == 1) {
                return [js[0], i];
            } else if (js.length > 1) {
                return [];
            }
            foreach (j; G[i]) {
                memo[j] = true;
                auto r = walk(j, i);
                if (!r.empty) return r ~ i;
                memo[j] = false;
            }
            return [];
        }
        memo[n] = true;
        auto r = walk(n, -1);
        if (r.empty) continue;
        auto rr = [r[0]];
        foreach (p; r[1..$]) {
            if (p == rr[0]) break;
            rr ~= p;
        }
        if (!r.empty) {
            writeln(rr.length);
            foreach (p; rr) writeln(p + 1);
            return;
        }
    }
    writeln(-1);
}