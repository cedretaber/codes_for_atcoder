import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;
 
void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];
    auto xy = readln.split.to!(int[]);
    auto sy = xy[0]-1;
    auto sx = xy[1]-1;
    auto gy = xy[2]-1;
    auto gx = xy[3]-1;
 
    auto MAP = new char[][H];
    foreach (i; 0..H) MAP[i] = readln.chomp.to!(char[]);
 
    auto DP = new int[][](H, W);
    foreach (ref dp; DP) dp[] = int.max;
 
    auto ss = [[sx, sy, 0]];
    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        auto x = h[0];
        auto y = h[1];
        auto c = h[2];
 
        foreach (i, d; [[0, -1], [-1, 0], [0, 1], [1, 0]]) {
            foreach (n; 1..K+1) {
                auto dx = x + n * d[0];
                auto dy = y + n * d[1];
                if (dx < 0 || dx >= W || dy < 0 || dy >= H || MAP[dy][dx] == '@' || DP[dy][dx] < c) break;
                if (DP[dy][dx] == c) continue;
                DP[dy][dx] = c;
 
                if (dx == gx && dy == gy) {
                    writeln(c+1);
                    return;
                }
 
                ss ~= [dx, dy, c+1];
            }
        }
    }
    writeln(-1);
}