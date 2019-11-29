import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias To = Tuple!(int, int);

void main()
{
    auto N = readln.chomp.to!int;
    bool[To][][] G;
    G.length = N;
    foreach (i; 0..N) {
        G[i].length = N;
        auto AS = readln.split.to!(int[]);
        foreach (j; 0..N-2) {
            auto a = i;
            auto b = AS[j]-1;
            if (a > b) swap(a, b);
            auto c = i;
            auto d = AS[j+1]-1;
            if (c > d) swap (c, d);
            G[a][b][To(c, d)] = true;
        }
    }

    auto memo = new int[][](N, N);
    auto max_d = new int[][](N, N);

    int x, max_w;
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            x += 2;
            int solve(int a, int b) {
                if (memo[a][b] < x) {
                    memo[a][b] = x;
                } else {
                    ++memo[a][b];
                }
                if (max_d[a][b]) return max_d[a][b];
                int e;
                foreach (to, _; G[a][b]) {
                    auto c = to[0];
                    auto d = to[1];
                    if (memo[c][d] == x+2) return -1;
                    auto r = solve(c, d);
                    if (r == -1) return -1;
                    e = max(e, r);
                }
                ++e;
                max_d[a][b] = e;
                max_w = max(e, max_w);
                return e;
            }
            if (max_d[i][j] == 0 && solve(i, j) == -1) {
                writeln("-1");
                return;
            }
        }
    }
    writeln(max_w);
}