import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias S = Tuple!(int, "x", int, "y", int, "c");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto MAP = new char[][](H, W);
    int x, y;
    foreach (i; 0..H) {
        foreach (j, c; readln.chomp) {
            if (c == 's') {
                x = j.to!int;
                y = i;
            }
            MAP[i][j] = c;
        }
    }
    auto memo = new bool[][](H, W);
    memo[y][x] = true;
    auto ss = DList!S(S(x, y, 0));
    while (!ss.empty) {
        auto h = ss.front;
        ss.removeFront();
        foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
            x = h.x+d[0];
            y = h.y+d[1];
            if (x < 0 || x >= W || y < 0 || y >= H || memo[y][x]) continue;
            memo[y][x] = true;
            if (MAP[y][x] == 'g') {
                writeln("YES");
                return;
            }
            auto c = h.c + (MAP[y][x] == '#' ? 1 : 0);
            if (c > 2) continue;
            if (MAP[y][x] == '#') {
                ss.insertBack(S(x, y, c));
            } else {
                ss.insertFront(S(x, y, c));
            }
        }
    }
    writeln("NO");
}