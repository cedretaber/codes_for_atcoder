import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] T;
    int[int][] Ti;
    T.length = N;
    Ti.length = N;
    foreach (_; 0..N-1) {
        auto abt = readln.split.to!(int[]);
        auto a = abt[0] - 1;
        auto b = abt[1] - 1;
        auto t = abt[2];
        T[a] ~= b;
        Ti[a][b] = T[a].length.to!int-1;
        if (t == 2) {
            T[b] ~= a;
            Ti[b][a] = T[b].length.to!int-1;
        }
    }
    int[][] css, lss, rss;
    css.length = N;
    lss.length = N;
    rss.length = N;
    foreach (i; 0..N) {
        css[i].length = T[i].length;
        lss[i].length = T[i].length;
        rss[i].length = T[i].length;
    }

    auto last_mark = new int[](N);
    auto memo = new int[](N);
    last_mark[] = -1;
    int solve(int i, int p) {
        if (T[i].length == 0) return 1;

        void build() {
            lss[i][0] = css[i][0];
            if (css[i].length > 1) foreach (j; 1..css[i].length) lss[i][j] = max(lss[i][j-1], css[i][j]);
            rss[i][$-1] = css[i][$-1];
            if (css[i].length > 1) foreach_reverse (j; 0..css[i].length-1) rss[i][j] = max(rss[i][j+1], css[i][j]);
            last_mark[i] = N;
        }

        if (last_mark[i] == -1) {
            int max_r;
            foreach (idx, j; T[i]) if (j != p) {
                auto r = solve(j, i);
                css[i][idx] = r;
                max_r = max(max_r, r);
            }
            if (p !in Ti[i]) {
                build();
            } else {
                memo[i] = max_r;
                last_mark[i] = p;
            }
            return max_r + 1;
        } else if (last_mark[i] == p) {
            return memo[i] + 1;
        } else if (last_mark[i] != N) {
            auto pi = Ti[i][last_mark[i]];
            css[i][pi] = solve(T[i][pi], i);
            build();
        }

        if (T[i].length == 1) return p == T[i][0] ? 1 : css[i][0] + 1;
        if (p == -1) return rss[i][0] + 1;
        if (p !in Ti[i]) return rss[i][0] + 1;

        auto pi = Ti[i][p];
        if (pi == 0) {
            return rss[i][1] + 1;
        } else if (pi == css[i].length-1) {
            return lss[i][$-2] + 1;
        } else {
            return max(lss[i][pi-1], rss[i][pi+1]) + 1;
        }
    }

    int r;
    foreach (i; 0..N) r = max(r, solve(i, -1));
    writeln(max(0, r-2));
}