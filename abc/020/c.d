import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "x", int, "y", int, "w", int, "b");

int[100][10][10] W_MEMO, B_MEMO;

void main()
{
    auto hwt = readln.split;
    auto H = hwt[0].to!int;
    auto W = hwt[1].to!int;
    auto T = hwt[2].to!long;

    char[][] MAP;
    MAP.length = H;
    int s_x, s_y, g_x, g_y;
    foreach (i; 0..H) {
        MAP[i] = readln.chomp.to!(char[]);
        foreach (j, c; MAP[i]) {
            if (c == 'S') {
                s_x = j.to!int;
                s_y = i.to!int;
            }
            if (c == 'G') {
                g_x = j.to!int;
                g_y = i.to!int;
            }
        }
    }

    foreach (y; 0..10) {
        foreach (x; 0..10) {
            if (y != s_y || x != s_x) {
                foreach (ref n; W_MEMO[y][x]) n = int.max;
                foreach (ref n; B_MEMO[y][x]) n = int.max;
            }
        }
    }

    auto ss = [P(s_x, s_y, 0, 0)];
    while (!ss.empty) {
        auto head = ss[0];
        ss = ss[1..$];
        foreach (xy; [[1, 0], [0, 1], [-1, 0], [0, -1]]) {
            auto nx = head.x + xy[0];
            auto ny = head.y + xy[1];
            auto w = head.w;
            auto b = head.b;
            if (nx < 0 || nx >= W || ny < 0 || ny >= H) continue;
            auto p = MAP[ny][nx];
            if (p == '.') {
                ++w;
            } else if (p == '#') {
                ++b;
            }
            if (b >= 100 || w >= 100) continue;
            if (W_MEMO[ny][nx][b] <= w || B_MEMO[ny][nx][w] <= b) continue;
            W_MEMO[ny][nx][b] = w;
            B_MEMO[ny][nx][w] = b;
            ss ~= P(nx, ny, w, b);
        }
    }

    long r = long.min;
    foreach (int w, b; B_MEMO[g_y][g_x]) {
        r = max(r, (T - w - 1) / b);
    }
    foreach (int b, w; W_MEMO[g_y][g_x]) {
        if (!b) continue;
        r = max(r, (T - w - 1) / b);
    }
    writeln(r);
}