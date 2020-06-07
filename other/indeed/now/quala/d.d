import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    auto g = new int[](H*W);
    foreach (i; 0..H*W-1) g[i] = i+1;

    int[] s;
    foreach (_; 0..H) foreach (c; readln.split) s ~= c.to!int;

    bool[immutable(int)[]] memo;
    auto ss = [s];
    foreach (t; 0..25) {
        int[][] nss;
        foreach (x; ss) {
            if (x == g) {
                writeln(t);
                return;
            }
            int ii, jj;
            foreach (k, c; x) if (c == 0) {
                ii = (k/W).to!int;
                jj = (k%W).to!int;
            }
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto i = ii + d[0];
                auto j = jj + d[1];
                if (i < 0 || i >= H || j < 0 || j >= W) continue;
                int[] y;
                foreach (c; x) y ~= c;
                swap(y[ii*W+jj], y[i*W+j]);
                if ((cast(immutable(int)[])y) in memo) continue;
                memo[cast(immutable(int)[])y] = true;
                nss ~= y;
            }
        }
        ss = nss;
        if (ss.length > 2000) {
            sort!((x, y) {
                int a, b;
                foreach (n; 0..H*W) {
                    int i, j;
                    if (n == 0) {
                        i = H-1;
                        j = W-1;
                    } else {
                        i = n/W;
                        j = n%W;
                    }
                    if (x[n] == 0) {
                        a += abs(i - H-1) + abs(j - W-1);
                    } else {
                        a += abs(i - (x[n]-1)/W) + abs(j - (x[n]-1)%W);
                    }
                    if (y[n] == 0) {
                        b += abs(i - H-1) + abs(j - W-1);
                    } else {
                        b += abs(i - (y[n]-1)/W) + abs(j - (y[n]-1)%W);
                    }
                }
                return a < b;
            })(ss);
            ss = ss[0..2000];
        }
    }
}