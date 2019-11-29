import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum O = [[1,0], [0,1], [-1,0], [0, -1]];

void main()
{
    auto S = readln.chomp;
    auto g = readln.split.to!(int[]);
    auto gx = g[0];
    auto gy = g[1];

    if (gx == 0 && gy == 0) {
        writeln("Yes");
        return;
    }

    auto o = [0,1,2,3];
    do {
        auto to = [O[o[0]], O[o[1]], O[o[2]], O[o[3]]];
        int x, y;
        foreach (s; S) {
            auto xy = to[s - 'W'];
            x += xy[0];
            y += xy[1];
            if (x == gx && y == gy) {
                writeln("Yes");
                return;
            }
        }
    } while (nextPermutation(o));

    writeln("No");
}