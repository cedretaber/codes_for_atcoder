import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias M = Tuple!(long, "x", long, "h");

void main()
{
    auto nda = readln.split.to!(long[]);
    auto N = nda[0];
    auto D = nda[1];
    auto A = nda[2];
    M[] MS;
    foreach (_; 0..N) {
        auto xh = readln.split.to!(long[]);
        MS ~= M(xh[0], xh[1]);
    }
    sort!"a.x < b.x"(MS);
    auto dc = new long[](N);
    long d, x;
    foreach (i; 0..N) {
        d += dc[i];
        auto h = MS[i].h - d;
        if (h <= 0) continue;
        auto y = (h + A - 1) / A;
        x += y;
        if (i == N-1) continue;
        d += A*y;
        auto rg = MS[i].x + D*2;
        if (MS[i+1].x > rg) {
            dc[i+1] -= A*y;
        } else if (MS[$-1].x > rg) {
            auto l = i+1, r = N-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (MS[m].x > rg) {
                    r = m;
                } else {
                    l = m;
                }
            }
            dc[r] -= A*y;
        }
    }
    writeln(x);
}