import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    char[][] MAP;
    MAP.length = H;
    foreach (i; 0..H) {
        MAP[i] = readln.chomp.to!(char[]);
    }

    int r;
    foreach (h; 0..H) {
        foreach (w; 0..W) {
            if (MAP[h][w] == '#') continue;
            auto memo = new bool[][](H, W);
            int t;
            int[2][] ss = [[h, w]];
            memo[h][w] = true;
            for (;;) {
                int[2][] nss;
                foreach (s; ss) {
                    foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                        auto y = s[0] + d[0];
                        auto x = s[1] + d[1];
                        if (y < 0 || y >= H || x < 0 || x >= W || memo[y][x] || MAP[y][x] == '#') continue;
                        memo[y][x] = true;
                        nss ~= [y, x];
                    }
                }
                if (nss.empty) break;
                ++t;
                ss = nss;
            }
            r = max(r, t);
        }
    }
    writeln(r);
}