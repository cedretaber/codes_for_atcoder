import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    char[][] P;
    P.length = H;
    foreach (i; 0..H) {
        P[i] = readln.chomp.to!(char[]);
    }

    char[][] Q;
    Q.length = H;
    foreach (ref line; Q) line.length = W;

    foreach (y; 0..H) {
        foreach (x; 0..W) {
            foreach (dy; -1..2) {
                foreach (dx; -1..2) {
                    auto nx = x+dx;
                    auto ny = y+dy;
                    if (nx < 0 || nx >= W || ny < 0 || ny >= H) continue;
                    if (P[ny][nx] == '.') goto next;
                }
            }
            Q[y][x] = '#';
            continue;
            next:
            Q[y][x] = '.';
        }
    }

    foreach (y; 0..H) {
        foreach (x; 0..W) {
            if (P[y][x] == '#') {
                foreach (dy; -1..2) {
                    foreach (dx; -1..2) {
                        auto nx = x+dx;
                        auto ny = y+dy;
                        if (nx < 0 || nx >= W || ny < 0 || ny >= H) continue;
                        if (Q[ny][nx] == '#') goto next2;
                    }
                }
                writeln("impossible");
                return;
                next2:
            }
        }
    }

    writeln("possible");
    foreach (line; Q) {
        writeln(line);
    }
}