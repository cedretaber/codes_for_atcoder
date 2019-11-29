import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];

    char[][] MAP;
    MAP.length = H;
    size_t sx, sy;
    foreach (i; 0..H) {
        MAP[i] = readln.chomp.to!(char[]);
        foreach (j, c; MAP[i]) if (c == 'S') {
            sx = j;
            sy = i;
        }
    }
    auto memo = new bool[][](H, W);
    memo[sy][sx] = true;
    auto ss = [[sx.to!int, sy.to!int]];
    foreach (_; 0..K) {
        if (ss.empty) break;
        int[][] nss;
        foreach (s; ss) {
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto x = s[0] + d[0];
                auto y = s[1] + d[1];
                if (x < 0 || x >= W || y < 0 || y >= H || memo[y][x] || MAP[y][x] == '#') continue;
                memo[y][x] = true;
                nss ~= [x, y];
            }
        }
        ss = nss;
    }

    int r = int.max;
    foreach (y; 0..H) foreach (x; 0..W) if (memo[y][x]) {
        if (x == 0 || y == 0 || x == W-1 || y == H-1) r = 0;
        r = min(r, min((y-1+K)/K, (x-1+K)/K, (H-y+K-2)/K, (W-x+K-2)/K));
    }
    writeln(r+1);
}