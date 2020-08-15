import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

static int[] xs1, ys1, xs2, ys2;
int xlen, ylen;

void read(int H, int W, int N)
{
    int[] xs = [0], ys = [0];
    foreach (_; 0..N) {
        auto xy = readln.split.to!(int[]);
        xs ~= [xy[0], xy[2]];
        ys ~= [xy[1], xy[3]];
        xs1 ~= xy[0];
        ys1 ~= xy[1];
        xs2 ~= xy[2];
        ys2 ~= xy[3];
    }
    xs ~= W;
    ys ~= H;

    sort(xs);
    sort(ys);
    int[int] mm;
    foreach (x; xs) if (x !in mm) mm[x] = xlen++;
    foreach (ref x; xs1) x = mm[x];
    foreach (ref x; xs2) x = mm[x];
    mm.clear();
    foreach (y; ys) if (y !in mm) mm[y] = ylen++;
    foreach (ref y; ys1) y = mm[y];
    foreach (ref y; ys2) y = mm[y];
}

void main()
{
    auto wh = readln.split.to!(int[]);
    auto W = wh[0];
    auto H = wh[1];
    auto N = readln.chomp.to!int;
    read(H, W, N);

    auto T = new int[][](ylen, xlen);
    foreach (i; 0..N) {
        auto x1 = xs1[i];
        auto y1 = ys1[i];
        auto x2 = xs2[i];
        auto y2 = ys2[i];
        T[y1][x1] += 1;
        T[y1][x2] -= 1;
        T[y2][x1] -= 1;
        T[y2][x2] += 1;
    }
    foreach (i; 0..ylen) foreach (j; 1..xlen) T[i][j] += T[i][j-1];
    foreach (i; 1..ylen) foreach (j; 0..xlen) T[i][j] += T[i-1][j];

    int c;
    foreach (i; 0..ylen-1) foreach (j; 0..xlen-1) if (T[i][j] == 0) {
        c -= 1;
        T[i][j] = c;
        auto ss = [[i, j]];
        while (!ss.empty) {
            int[][] nss;
            foreach (h; ss) {
                foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                    auto y = h[0]+d[0];
                    auto x = h[1]+d[1];
                    if (y < 0 || y >= ylen-1 || x < 0 || x >= xlen-1 || T[y][x] != 0) continue;
                    T[y][x] = c;
                    nss ~= [y, x];
                }
            }
            ss = nss;
        }
    }
    writeln(abs(c));
}