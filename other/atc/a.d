import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto MAP = new char[][](H, W);
    int x, y;
    foreach (i; 0..H) {
        foreach (j, c; readln.chomp.to!(char[])) {
            if (c == 's') {
                x = j.to!int;
                y = i.to!int;
            }
            MAP[i][j] = c;
        }
    }

    auto memo = new bool[][](H, W);
    auto ss = [[x, y]];
    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
            x = h[0]+d[0];
            y = h[1]+d[1];
            if (x < 0 || x >= W || y < 0 || y >= H || MAP[y][x] == '#' || memo[y][x]) continue;
            if (MAP[y][x] == 'g') {
                writeln("Yes");
                return;
            }
            memo[y][x] = true;
            ss ~= [x, y];
        }
    }
    writeln("No");
}