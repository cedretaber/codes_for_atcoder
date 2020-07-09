import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto ss = new int[][](N, N);
    auto memo = new bool[][](N, N);
    foreach (i; 0..N) foreach (j; 0..N) {
        ss[i][j] = min(i, N-i-1, j, N-j-1);
        memo[i][j] = true;
    }

    void recalc(int i, int j) {
        auto d = ss[i][j] + (memo[i][j] ? 1 : 0);
        static foreach (s; [[1,0], [0,1], [-1,0], [0,-1]]) {{
            auto ii = i+s[0];
            auto jj = j+s[1];
            if (!(ii < 0 || ii >= N || jj < 0 || jj >= N) && ss[ii][jj] > d) {
                ss[ii][jj] = d;
                recalc(ii, jj);
            }
        }}
    }

    int r;
    foreach (p; readln.split.to!(int[])) {
        auto i = (p-1)/N;
        auto j = (p-1)%N;
        r += ss[i][j];
        memo[i][j] = false;
        recalc(i, j);
    }
    writeln(r);
}