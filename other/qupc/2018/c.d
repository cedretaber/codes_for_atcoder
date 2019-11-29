import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum D = [[1,0], [0,1], [-1,0], [0,-1]];

void main()
{
    auto hwx = readln.split.to!(int[]);
    auto H = hwx[0];
    auto W = hwx[1];
    auto X = hwx[2];

    char[][] MAP;
    MAP.length = H;
    int[2] start;
    int[2][] as;
    foreach (i; 0..H) {
        MAP[i].length = W;
        foreach (j, c; readln.chomp.to!(char[])) {
            MAP[i][j] = c;
            switch (c) {
                case 'S':
                    start = [j.to!int, i];
                    break;
                case '@':
                    as ~= [j.to!int, i];
                    break;
                default:
            }
        }
    }

    while (X) {
        int[2][] nas;
        foreach (a; as) {
            foreach (d; D) {
                auto dx = a[0] + d[0];
                auto dy = a[1] + d[1];
                if (dx < 0 || dx >= W || dy < 0 || dy >= H) continue;
                auto m = MAP[dy][dx];
                if (m == '#' || m == '@') continue;
                MAP[dy][dx] = '@';
                nas ~= [dx, dy];
            }
        }
        as = nas;
        --X;
    }

    auto ss = [start];
    int c = 1;
    while (!ss.empty) {
        int[2][] nss;
        foreach (s; ss) {
            foreach (d; D) {
                auto dx = s[0] + d[0];
                auto dy = s[1] + d[1];
                if (dx < 0 || dx >= W || dy < 0 || dy >= H) continue;
                auto m = MAP[dy][dx];
                if (m == '#' || m == '@') continue;
                MAP[dy][dx] = '#';
                if (m == 'G') {
                    writeln(c);
                    return;
                }
                nss ~= [dx, dy];
            }
        }
        ss = nss;
        ++c;
    }

    writeln(-1);
}