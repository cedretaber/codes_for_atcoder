import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    string[][] map;
    map.length = H;
    foreach (i; 0..H) {
        map[i] = readln.chomp.split("");
    }

    foreach (y; 0..H) {
        bool b;
        foreach (x; 0..W) {
            if (map[y][x] == "#") {
                b = true;
                break;
            }
        }
        if (!b) {
            foreach (x; 0..W) {
                map[y][x] = "";
            }
        }
    }

    foreach (x; 0..W) {
        bool b;
        foreach (y; 0..H) {
            if (map[y][x] == "#") {
                b = true;
                break;
            }
        }
        if (!b) {
            foreach (y; 0..H) {
                map[y][x] = "";
            }
        }
    }

    foreach (line_; map) {
        auto line = line_.join;
        if (!line) continue;
        writeln(line);
    }
}