import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] MAP;
    MAP.length = H;
    foreach (ref line; MAP) line = readln.chomp.to!(char[]);

    long r;
    foreach (y; 0..H) {
        foreach (x; 0..W) {
            foreach (d; 1..300) {
                int s;
                foreach (xy; [[d, 0], [0, d], [-d, 0], [0, -d]]) {
                    auto xd = x + xy[0];
                    auto yd = y + xy[1];
                    if (xd < 0 || xd >= W || yd < 0 || yd >= H || MAP[yd][xd] == '.') continue;
                    ++s;
                }
                if (s == 3) r += 1;
                else if (s == 4) r += 4;
                if (MAP[y][x] == '.' || d%3 != 0) continue;
                auto e = d/3;
                foreach (xy; [
                    [-d, e, -e, d],
                    [e, d, d, e],
                    [d, -e, e, -d],
                    [-e, -d, -d, -e]
                ]) {
                    auto x1 = x + xy[0];
                    auto y1 = y + xy[1];
                    auto x2 = x + xy[2];
                    auto y2 = y + xy[3];
                    if (
                        x1 < 0 || x1 >= W || y1 < 0 || y1 >= H ||
                        x2 < 0 || x2 >= W || y2 < 0 || y2 >= H ||
                        MAP[y1][x1] == '.' || MAP[y2][x2] == '.'
                    ) continue;
                    ++r;
                }
            }
        }
    }
    writeln(r);
}