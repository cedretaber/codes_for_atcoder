import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    char[][] MAP;
    MAP.length = H;
    foreach (ref line; MAP) {
        line = readln.chomp.to!(char[]);
    }

    int[][] HMAP, WMAP;
    HMAP.length = H;
    WMAP.length = H;
    foreach (i; 0..H) {
        HMAP[i].length = W;
        WMAP[i].length = W;
    }

    foreach (i; 0..H) {
        int x;
        foreach (j; 0..W) {
            if (MAP[i][j] == '#') {
                x = 0;
            } else {
                WMAP[i][j] = ++x;
            }
        }
        x = 0;
        foreach_reverse (j; 0..W) {
            if (MAP[i][j] == '#') {
                x = 0;
                continue;
            }
            if (WMAP[i][j] > x) {
                x = WMAP[i][j];
            } else {
                WMAP[i][j] = x;
            }
        }
    }

    foreach (j; 0..W) {
        int x;
        foreach (i; 0..H) {
            if (MAP[i][j] == '#') {
                x = 0;
            } else {
                HMAP[i][j] = ++x;
            }
        }
        x = 0;
        foreach_reverse (i; 0..H) {
            if (MAP[i][j] == '#') {
                x = 0;
                continue;
            }
            if (HMAP[i][j] > x) {
                x = HMAP[i][j];
            } else {
                HMAP[i][j] = x;
            }
        }
    }

    int r;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            r = max(r, HMAP[i][j] + WMAP[i][j] - 1);
        }
    }
    writeln(r);
}