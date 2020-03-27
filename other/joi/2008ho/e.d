import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto wh = readln.split.to!(int[]);
    auto W = wh[0];
    auto H = wh[1];
    auto N = readln.chomp.to!int;
    int[] xs = [0], ys = [0], xs1, ys1, xs2, ys2;
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
    xs = xs.uniq().array();
    sort(ys);
    ys = ys.uniq().array();
    int[int] xm, ym;
    foreach (i, x; xs) xm[x] = i.to!int;
    foreach (i, y; ys) ym[y] = i.to!int;
    foreach (ref x; xs1) x = xm[x];
    foreach (ref y; ys1) y = ym[y];
    foreach (ref x; xs2) x = xm[x];
    foreach (ref y; ys2) y = ym[y];

    auto xlen = xs.length;
    auto ylen = ys.length;
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
            auto h = ss[0];
            ss = ss[1..$];
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto y = h[0]+d[0];
                auto x = h[1]+d[1];
                if (y < 0 || y >= ylen-1 || x < 0 || x >= xlen-1 || T[y][x] != 0) continue;
                T[y][x] = c;
                ss ~= [y, x];
            }
        }
    }
    writeln(abs(c));
}