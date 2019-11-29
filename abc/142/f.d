import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][1000] G, RG;
int[1000] MEMO;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        RG[B] ~= A;
    }

    int[] walk(int i, int p, int n) {
        foreach (j; RG[i]) if (j != p && MEMO[j] == n) return [];
        int[] js;
        foreach (j; G[i]) if (MEMO[j] == n) js ~= j;
        if (js.length == 1) {
            return [js[0]+1, i+1];
        } else if (js.length > 1) {
            return [];
        }
        foreach (j; G[i]) {
            MEMO[j] = n;
            auto r = walk(j, i, n);
            if (!r.empty) return r ~= i+1;
            MEMO[j] = 0;
        }
        return [];
    }
    
    foreach (i; 0..N) {
        MEMO[i] = i+1;
        auto r = walk(i, -1, i+1);
        if (!r.empty) {
            auto top = r[0];
            int[] rr = [top];
            foreach (p; r[1..$]) {
                if (p == top) break;
                rr ~= p;
            }
            reverse(rr);
            writeln(rr.length);
            writeln(rr.to!(string[]).join(" "));
            return;
        }
    }
    writeln("-1");
}