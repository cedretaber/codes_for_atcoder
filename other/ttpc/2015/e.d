import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[] YS, XS;
    foreach (_; 0..K) {
        auto yx = readln.split.to!(int[]);
        YS ~= yx[0];
        XS ~= yx[1];
    }

    int res;
    foreach (q; 0..(1<<K)) {
        int max_x, max_y, min_x = N, min_y = N;
        foreach (i; 0..K) if (q & (1<<i)) {
            auto x = XS[i];
            auto y = YS[i];
            max_x = max(max_x, x);
            min_x = min(min_x, x);
            max_y = max(max_y, y);
            min_y = min(min_y, y);
        }
        foreach (xxd; -1..2) foreach (ixd; -1..2) foreach (xyd; -1..2) foreach (iyd; -1..2) {
            auto xx = max_x + xxd;
            auto ix = min_x + ixd;
            auto xy = max_y + xyd;
            auto iy = min_y + iyd;
            if (xx > N || ix < 1 || xy > N || iy < 1) continue;
            auto dx = xx-ix+1;
            auto dy = xy-iy+1;
            int r;
            if ((dx*dy)%2 == 1) {
                if ((ix+iy)%2 == 0) {
                    ++r;
                } else {
                    --r;
                }
            }
            foreach (i; 0..K) {
                auto x = XS[i];
                auto y = YS[i];
                if (x < ix || x > xx || y < iy || y > xy) continue;
                if ((x+y)%2 == 0) {
                    r -= 2;
                } else {
                    r += 2;
                }
            }
            res = max(res, abs(r));
        }
    }
    writeln(res);
}