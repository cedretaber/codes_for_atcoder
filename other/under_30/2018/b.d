import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    auto ss = readln.split.to!(int[]);
    auto sx = ss[0];
    auto sy = ss[1];

    int[][] map;
    map.length = H;
    foreach (ref line; map) {
        line = readln.split.to!(int[]);
    }

    wchar[][] res;
    res.length = H;
    foreach (ref line; res) {
        res.length = W;
        foreach (ref e; line) e = '.';
    }

    int x = sx - 1, y = sy - 1;
    while (x != -1) {
        res[y][x] = 'W';
        int len = map[y][x], nx = -1, ny = -1;
        if (x > 0 && map[y][x-1] < len) {
            len = map[y][x-1];
            nx = x-1;
            ny = y;
        }
        if (x < W && map[y][x+1] < len) {
            len = map[y][x+1];
            nx = x + 1;
            ny = y;
        }
        if (y > 0 && map[y+1][x] < len) {
            len = map[y-1][x];
            nx = x;
            ny = y-1;
        }
        if (y < H && map[y-1][x] < len) {
            len = map[y+1][x];
            nx = x;
            ny = y+1;
        }
        x = nx;
        y = ny;
    }

    foreach (line; res) {
        writeln(line);
    }
}