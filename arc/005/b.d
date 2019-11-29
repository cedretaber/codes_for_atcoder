import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto xyw = readln.split;
    auto x = xyw[0].to!int - 1;
    auto y = xyw[1].to!int - 1;
    auto W = xyw[2] ~ "_";
    int dx, dy;
    if (W[0] == 'U' || W[1] == 'U') dy = -1;
    if (W[0] == 'D' || W[1] == 'D') dy = 1;
    if (W[0] == 'R') dx = 1;
    if (W[0] == 'L') dx = -1;

    char[][9] cs;
    foreach (ref line; cs) line = readln.chomp.to!(char[]);

    char[] p;
    foreach (_; 0..4) {
        p ~= cs[y][x];
        x += dx;
        y += dy;

        if (x < 0) {
            x = 1;
            dx = 1;
        }
        if (x >= 9) {
            x = 7;
            dx = -1;
        }
        if (y < 0) {
            y = 1;
            dy = 1;
        }
        if (y >= 9) {
            y = 7;
            dy = -1;
        }
    }
    writeln(p);
}