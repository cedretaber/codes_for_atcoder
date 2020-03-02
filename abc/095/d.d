import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nc = readln.split.to!(long[]);
    auto N = nc[0];
    auto C = nc[1];
    long[] xs, vs;
    foreach (_; 0..N) {
        auto xv = readln.split.to!(long[]);
        xs ~= xv[0];
        vs ~= xv[1];
    }

    auto rs = new long[](N);
    auto ls = new long[](N);
    long m, s;
    foreach (i; 0..N) {
        s += vs[i];
        rs[i] = max(i == 0 ? 0 : rs[i-1], s - xs[i]);
    }
    m = 0; s = 0;
    foreach_reverse (i; 0..N) {
        s += vs[i];
        ls[i] = max(i == N-1 ? 0 : ls[i+1], s - C + xs[i]);
    }

    long r;
    foreach (i; 0..N) {
        r = max(r, rs[i]);
        r = max(r, ls[i]);
        if (i < N-1) r = max(r, rs[i] - xs[i] + ls[i+1]);
        if (i > 0) r = max(r, ls[i] - C + xs[i] + rs[i-1]);
    }
    writeln(r);
}