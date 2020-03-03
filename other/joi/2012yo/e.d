import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum EVEN = [[0,1], [1,1], [0,-1], [1,-1], [1,0], [-1,0]];
enum ODD = [[-1,1], [0,1], [-1,-1], [0,-1], [1,0], [-1,0]];

void main()
{
    auto wh = readln.split.to!(int[]);
    auto W = wh[0];
    auto H = wh[1];
    int[][] MAP;
    MAP.length = H;
    foreach (i; 0..H) MAP[i] = readln.split.to!(int[]);

    void put(int x, int y) {
        if (MAP[y][x] != 0) return;

        MAP[y][x] = 2;
        auto ss = [[x, y]];
        while (!ss.empty) {
            auto h = ss[0];
            ss = ss[1..$];
            foreach (d; h[1]%2 == 0 ? EVEN : ODD) {
                auto xx = h[0]+d[0];
                auto yy = h[1]+d[1];
                if (xx < 0 || xx >= W || yy < 0 || yy >= H || MAP[yy][xx] != 0) continue;
                MAP[yy][xx] = 2;
                ss ~= [xx, yy];
            }
        }
    }
    foreach (i; 0..H) foreach (j; [0, W-1]) put(j, i);
    foreach (i; [0, H-1]) foreach (j; 0..W) put(j, i);

    int r;
    foreach (i; 0..H) foreach (j; 0..W) foreach (d; i%2 == 0 ? EVEN : ODD) if (MAP[i][j] == 1) {
        auto x = j+d[0];
        auto y = i+d[1];
        if (x < 0 || x >= W || y < 0 || y >= H || MAP[y][x] == 2) ++r;
    }
    writeln(r);
}