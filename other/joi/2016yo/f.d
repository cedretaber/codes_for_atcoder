import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    int[][] MAP;
    MAP.length = H;
    foreach (i; 0..H) {
        MAP[i].length = W;
        foreach (j, c; readln.chomp) {
            MAP[i][j] = c == '.' ? 0 : c-'0';
        }
    }

    auto DP = new int[][][](3, W, 2^^4);
    foreach (ref dp; DP[0]) dp[] = int.max/3;
    DP[0][0][0] = 0;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (i+1 < H) DP[(i+1)%3][j][] = int.max/3;
            foreach (s; 0..2^^4) {
                foreach (d; [[1,0],[0,1]]) {
                    auto y = i+d[0];
                    auto x = j+d[1];
                    if (y == H || x == W) continue;
                    foreach (k; 0..4) {
                        auto u = DP[i%3][j][s];
                        if (!(d[0] && (s & 0b0100)) && !(d[1] && (s & 0b0010))) u += MAP[y][x];
                        int v;
                        if (k != 0 && y+1 < H) {
                            u += MAP[y+1][x];
                            v |= 0b0100;
                        }
                        if (k != 1 && x+1 < W) {
                            u += MAP[y][x+1];
                            v |= 0b0010;
                        }
                        if (k != 2 && y-1 >= 0 && d[1] && !(s & 0b0001)) u += MAP[y-1][x];
                        if (k != 3 && x-1 >= 0 && d[0] && !(s & 0b1000)) u += MAP[y][x-1];
                        if (d[0] && (s & 0b0010)) v |= 0b0001;
                        if (d[1] && (s & 0b0100)) v |= 0b1000;
                        DP[y%3][x][v] = min(DP[y%3][x][v], u);
                    }
                }
            }
        }
    }

    int r = int.max;
    foreach (n; DP[(H-1)%3][W-1]) r = min(r, n);
    writeln(r);
}