import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nxy = readln.split.to!(int[]);
    auto N = nxy[0];
    auto X = nxy[1] + 205;
    auto Y = nxy[2] + 205;
    auto B = new bool[][](410, 410);
    foreach (_; 0..N) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0] + 205;
        auto y = xy[1] + 205;
        B[y][x] = true;
    }

    auto ss = [[205, 205, 0]];
    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        auto c = h[2];
        foreach (d; [[1,1], [0,1], [-1,1], [1,0], [-1,0], [0,-1]]) {
            auto x = h[0] + d[0];
            auto y = h[1] + d[1];
            if (x < 0 || x >= 410 || y < 0 || y >= 410 || B[y][x]) continue;
            if (X == x && Y == y) {
                writeln(c+1);
                return;
            }
            B[y][x] = true;
            ss ~= [x, y, c+1];
        }
    }
    writeln(-1);
}