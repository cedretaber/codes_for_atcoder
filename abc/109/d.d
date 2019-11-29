import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias OP = Tuple!(int, "y", int, "x", int, "ny", int, "nx");

int[500][500] AS;
OP[500 * 500] OPS;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    foreach (i; 0..H) {
        foreach (j, a; readln.split.to!(int[])) {
            AS[i][j] = a;
        }
    }

    if (H == 1 && W == 1) {
        writeln("0");
        return;
    }

    int x, y, nx, ny;
    if (W == 1) {
        ny = 1;
    } else {
        nx = 1;
    }

    int gx, gy = H-1;
    if (H % 2) gx = W-1;

    int i;
    for (;;) {
        if (AS[y][x] % 2) {
            OPS[i++] = OP(y, x, ny, nx);
            AS[ny][nx] += 1;
        }
        if (nx == gx && ny == gy) break;
        x = nx;
        y = ny;
        if (y % 2) {
            nx -= 1;
            if (nx < 0) {
                nx += 1;
                ny += 1;
            }
        } else {
            nx += 1;
            if (nx >= W) {
                nx -= 1;
                ny += 1;
            }
        }
    }
    writeln(i);
    foreach (op; OPS[0..i]) {
        writefln("%d %d %d %d", op.y+1, op.x+1, op.ny+1, op.nx+1);
    }
}