import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias E = Tuple!(int, "to", int, "cap", size_t, "rev");

E[][100+100+2] G;
bool[100+100+2] USED;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    auto lake = new char[][](H, W);
    int sx, sy, tx, ty;
    foreach (int y; 0..H) {
        foreach (int x, c; readln.chomp.to!(char[])) {
            lake[y][x] = c;
            if (c == 'S') {
                sx = x;
                sy = y;
            }
            if (c == 'T') {
                tx = x;
                ty = y;
            }
            if (c == 'o') {
                G[x] ~= E(100+y, 1, G[100+y].length);
                G[100+y] ~= E(x, 1, G[x].length-1);
            }
        }
    }

    G[200] ~= E(sx, 100000, G[sx].length);
    G[sx] ~= E(200, 0, 0);
    G[200] ~= E(sy+100, 100000, G[sy+100].length);
    G[sy+100] ~= E(200, 0, 1);

    G[201] ~= E(tx, 0, G[tx].length);
    G[tx] ~= E(201, 100000, 0);
    G[201] ~= E(ty+100, 0, G[ty+100].length);
    G[ty+100] ~= E(201, 100000, 0);

    if (sx == tx || sy == ty) {
        writeln(-1);
        return;
    }

    int solve(int i) {
        if (i == 201) return 1;
        USED[i] = true;
        foreach (ref e; G[i]) if (e.cap > 0 && !USED[e.to]) {
            if (solve(e.to)) {
                --e.cap;
                ++G[e.to][e.rev].cap;
                return 1;
            }
        }
        return 0;
    }
    int r;
    while (solve(200)) {
        USED[] = false;
        ++r;
    }
    writeln(r);
}