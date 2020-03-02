import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hwn = readln.split.to!(int[]);
    auto H = hwn[0];
    auto W = hwn[1];
    auto N = hwn[2];

    auto MAP = new char[][](H, W);
    int x, y;
    foreach (i; 0..H) foreach (j, c; readln.chomp.to!(char[])) {
        if (c == 'S') {
            x = j.to!int;
            y = i;
        }
        MAP[i][j] = c;
    }

    auto MEMO = new int[][](H, W);

    int r;
    foreach (i; 1..N+1) {
        auto g = ('0'+i).to!char;
        auto ss = [[x, y, 1]];
        MEMO[y][x] = i;
        for (;;) {
            auto s = ss[0];
            ss = ss[1..$];
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto xx = s[0]+d[0];
                auto yy = s[1]+d[1];
                if (xx < 0 || xx >= W || yy < 0 || yy >= H || MAP[yy][xx] == 'X' || MEMO[yy][xx] == i) continue;
                if (MAP[yy][xx] == g) {
                    x = xx;
                    y = yy;
                    r += s[2];
                    goto ok;
                }
                MEMO[yy][xx] = i;
                ss ~= [xx, yy, s[2]+1];
            }
        }
        ok:
    }
    writeln(r);
}