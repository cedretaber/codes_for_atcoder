import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rc = readln.split.to!(int[]);
    auto R = rc[0];
    auto C = rc[1];
    auto s = readln.split.to!(int[]);
    auto sy = s[0]-1;
    auto sx = s[1]-1;
    auto g = readln.split.to!(int[]);
    auto gy = g[0]-1;
    auto gx = g[1]-1;
    char[][] MAP;
    MAP.length = R;
    foreach (ref line; MAP) line = readln.chomp.to!(char[]);
    auto MEMO = new bool[][](R, C);

    auto ss = [[sx, sy]];
    MEMO[sy][sx] = true;
    for (int i;; ++i) {
        int[][] nss;
        foreach (r; ss) {
            foreach (d; [[1, 0], [0, 1], [-1, 0], [0, -1]]) {
                auto dx = r[0] + d[0];
                auto dy = r[1] + d[1];
                if (dx < 0 || dx >= C || dy < 0 || dy >= R || MEMO[dy][dx] || MAP[dy][dx] == '#') continue;
                if (dx == gx && dy == gy) {
                    writeln(i+1);
                    return;
                }
                MEMO[dy][dx] = true;
                nss ~= [dx, dy];
            }
        }
        ss = nss;
    }
}