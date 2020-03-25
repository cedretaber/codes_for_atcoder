import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "x", int, "y", int, "d");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    P[] as, bs;
    long[] xs, ys, ds;
    foreach (_; 0..N) {
        auto xyd = readln.split.to!(int[]);
        auto x1 = xyd[0];
        auto y1 = xyd[1];
        auto d1 = xyd[2];
        auto x2 = xyd[3];
        auto y2 = xyd[4];
        auto d2 = xyd[5];
        as ~= P(x1, y1, d1);
        bs ~= P(x2, y2, d2);
        xs ~= [x1, x2];
        ys ~= [y1, y2];
        ds ~= [d1, d2];
    }
    sort(xs);
    xs = xs.uniq().array();
    sort(ys);
    ys = ys.uniq().array();
    sort(ds);
    ds = ds.uniq().array();
    int[long] xm, ym, dm;
    foreach (i, x; xs) xm[x] = i.to!int;
    foreach (i, y; ys) ym[y] = i.to!int;
    foreach (i, d; ds) dm[d] = i.to!int;
    foreach (ref a; as) a = P(xm[a.x], ym[a.y], dm[a.d]);
    foreach (ref b; bs) b = P(xm[b.x], ym[b.y], dm[b.d]);
    auto xl = xs.length;
    auto yl = ys.length;
    auto dl = ds.length;

    auto cs = new int[][][](xl, yl, dl);
    foreach (i; 0..N) {
        auto a = as[i];
        auto b = bs[i];
        cs[a.x][a.y][a.d] += 1;
        cs[a.x][b.y][a.d] -= 1;
        cs[b.x][a.y][a.d] -= 1;
        cs[b.x][b.y][a.d] += 1;
        cs[a.x][a.y][b.d] -= 1;
        cs[a.x][b.y][b.d] += 1;
        cs[b.x][a.y][b.d] += 1;
        cs[b.x][b.y][b.d] -= 1;
    }
    foreach (i; 1..xl) foreach (j; 0..yl) foreach (k; 0..dl) cs[i][j][k] += cs[i-1][j][k];
    foreach (i; 0..xl) foreach (j; 1..yl) foreach (k; 0..dl) cs[i][j][k] += cs[i][j-1][k];
    foreach (i; 0..xl) foreach (j; 0..yl) foreach (k; 1..dl) cs[i][j][k] += cs[i][j][k-1];

    long r;
    foreach (i; 0..xl-1) foreach (j; 0..yl-1) foreach (k; 0..dl-1) if (cs[i][j][k] >= K) {
        r += (xs[i+1] - xs[i]) * (ys[j+1] - ys[j]) * (ds[k+1] - ds[k]);
    }
    writeln(r);
}