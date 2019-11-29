import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias S = Tuple!(int, "x", int, "y", int, "c");

void main()
{
    auto rc = readln.split.to!(int[]);
    auto R = rc[0];
    auto C = rc[1];

    int[][] RC;
    RC.length = R;
    foreach (ref c; RC) {
        c.length = C;
        foreach (ref n; c) n = int.max;
    }

    wchar[][] O;
    O.length = R;
    int s_x, s_y, t_x, t_y;
    foreach (int y, ref l; O) {
        l = readln.chomp.to!(wchar[]);
        foreach (int x, c; l) {
            if (c == 's') {
                s_x = x;
                s_y = y;
            }
            if (c == 't') {
                t_x = x;
                t_y = y;
            }
        }
    }

    auto DRS = [
        [[1, 0], [-1, 0], [-1, 1], [0, 1], [-1, -1], [0, -1]], // even
        [[1, 0], [-1, 0], [0, 1], [1, 1], [0, -1], [1, -1]] // odd
    ];
    auto ss = [S(s_x, s_y, 0)];
    RC[s_y][s_x] = true;
    int[] res;
    while (!ss.empty) {
        auto s = ss[0];
        ss = ss[1..$];
        foreach (dr; DRS[s.y % 2]) {
            auto x = s.x + dr[0];
            auto y = s.y + dr[1];
            if (x < 0 || x >= C || y < 0 || y >= R) continue;
            if (x == t_x && y == t_y) {
                res ~= s.c;
                continue;
            }
            auto c = s.c + O[y][x] - 48;
            if (RC[y][x] <= c) continue;
            RC[y][x] = c;
            ss ~= S(x, y, c);
        }
    }
    sort(res);
    writeln(res[0]);
}