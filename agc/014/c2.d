import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];
    auto MAP = new char[][](H, W);
    auto MEMO = new bool[][](H, W);
    int sx, sy;
    foreach (i; 0..H) foreach (j, c; readln.chomp.to!(char[])) {
        if (c == 'S') {
            sx = j.to!int;
            sy = i;
            MEMO[i][j] = true;
        }
        MAP[i][j] = c;
    }
    auto ss = [[sx, sy]];
    foreach (_; 0..K) {
        int[][] nss;
        foreach (s; ss) {
            auto x = s[0];
            auto y = s[1];
            static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
                auto xx = x+d[0];
                auto yy = y+d[1];
                if (0 <= xx && xx < W && 0 <= yy && yy < H && MAP[yy][xx] == '.' && !MEMO[yy][xx]) {
                    MEMO[yy][xx] = true;
                    nss ~= [xx, yy];
                    if (xx == 0 || xx == W-1 || yy == 0 || yy == H-1) {
                        writeln(1);
                        return;
                    }
                }
            }}
        }
        ss = nss;
    }
    auto r = int.max;
    foreach (i; 0..H) foreach (j; 0..W) if (MEMO[i][j]) {
        r = min(r, min((i-1+K)/K, (j-1+K)/K, (H-i-2+K)/K, (W-j-2+K)/K));
    }
    writeln(r+1);
}