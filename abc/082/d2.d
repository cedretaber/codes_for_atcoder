import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

bool solve(int s, int g, int[] ns) {
    auto N = ns.length;
    auto DP = new bool[][](N+1, 8000*2+1);
    void sv(int i, int n) {
        if (!DP[i][n]) {
            DP[i][n] = true;
            if (i == N) return;
            sv(i+1, n+ns[i]);
            sv(i+1, n-ns[i]);
        }
    }
    sv(0, s+8000);
    return DP[N][g+8000];
}

void main()
{
    int[] xs, ys;
    int n, t;
    auto s = readln.chomp;
    foreach (c; s) {
        if (c == 'T') {
            if (n != 0) {
                if (t%2 == 0) {
                    xs ~= n;
                } else {
                    ys ~= n;
                }
                n = 0;
            }
            ++t;
        } else {
            ++n;
        }
    }
    if (n != 0) {
        if (t%2 == 0) {
            xs ~= n;
        } else {
            ys ~= n;
        }
    }
    int x;
    if (s[0] != 'T') {
        x = xs[0];
        xs = xs[1..$];
    }

    auto xy = readln.split.to!(int[]);
    auto gx = xy[0];
    auto gy = xy[1];

    writeln(solve(x, gx, xs) && solve(0, gy, ys) ? "Yes" : "No");
}