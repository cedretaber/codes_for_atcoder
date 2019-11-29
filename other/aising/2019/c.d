import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    wchar[][] map;
    map.length = H;
    foreach (i; 0..H) {
        map[i] = readln.chomp.to!(wchar[]);
    }

    bool[][] memo;
    memo.length = H;
    foreach (ref line; memo) {
        line.length = W;
    }

    long[wchar][] css;
    foreach (x; 0..W) {
        foreach (y; 0..H) {
            if (memo[y][x]) continue;
            alias S = Tuple!(int, "x", int, "y", wchar, "colour");
            long[wchar] cs = ['#': 0, '.': 0];
            S[] ss = [S(x, y, map[y][x])];
            while (!ss.empty) {
                auto h = ss[0];
                ss = ss[1..$];
                if (memo[h.y][h.x]) continue;
                ++cs[h.colour];
                memo[h.y][h.x] = true;
                foreach (d; [[0, 1], [0, -1], [1, 0], [-1, 0]]) {
                    auto yy = h.y + d[0];
                    auto xx = h.x + d[1];
                    if (yy < 0 || yy >= H || xx < 0 || xx >= W) continue;
                    auto c = map[yy][xx];
                    if (h.colour == c) continue;
                    ss ~= S(xx, yy, c);
                }
            }
            css ~= cs;
        }
    }

    long sum;
    foreach (cs; css) {
        sum += cs['#'] * cs['.'];
    }
    writeln(sum);
}