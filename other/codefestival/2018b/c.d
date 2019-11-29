import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[2][4] DIRS = [[1,0], [0,1], [-1,0], [0,-1]];

void main()
{
    auto N = readln.chomp.to!int;
    char[][] map;
    map.length = N;
    foreach (ref line; map) {
        line.length = N;
        foreach (ref c; line) c = '#';
    }

    int sp = -3;
    foreach (y; 0..N) {
        sp = (sp + 3) % 5;
        int x = sp;
        while (x < N) {
            map[y][x] = 'X';
            foreach (dir; DIRS) {
                auto xd = x + dir[0];
                auto yd = y + dir[1];
                if (xd < 0 || xd >= N || yd < 0 || yd >= N) continue;
                map[yd][xd] = '.';
            }
            x += 5;
        }
    }

    foreach (y; 0..N) {
        foreach (x; 0..N) {
            if (map[y][x] == '#') {
                map[y][x] = 'X';
                foreach (dir; DIRS) {
                    auto xd = x + dir[0];
                    auto yd = y + dir[1];
                    if (xd < 0 || xd >= N || yd < 0 || yd >= N) continue;
                    map[yd][xd] = '.';
                }
            }
        }
    }

    foreach (line; map) writeln(line);
}