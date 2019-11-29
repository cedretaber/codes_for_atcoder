import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    char[][] MAP;
    MAP.length = H;
    int s;
    foreach (i; 0..H) {
        MAP[i] = readln.chomp.to!(char[]);
        foreach (c; MAP[i]) if (c == '#') ++s;
    }

    int x, y, t;
    for (;;) {
        ++t;
        if (x < W-1 && MAP[y][x+1] == '#') {
            ++x;
        } else if (y < H-1 && MAP[y+1][x] == '#') {
            ++y;
        } else {
            break;
        }
    }
    writeln(s == t ? "Possible" : "Impossible");
}