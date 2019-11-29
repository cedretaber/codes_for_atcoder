import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias Point = Tuple!(long, "x", long, "y");

Point[50] PS;
int[51][51] SS;
long[50] XS, YS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto ps = PS[0..N];

    foreach (i; 0..N) {
        auto xy = readln.split.to!(long[]);
        PS[i] = Point(xy[0], xy[1]);
        XS[i] = xy[0];
        YS[i] = xy[1];
    }

    sort(XS[0..N]);
    sort(YS[0..N]);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            int cnt;
            foreach (p; ps) if (p.x <= XS[i] && p.y <= YS[j]) ++cnt;
            SS[j+1][i+1] = cnt;
        }
    }

    auto min_size = long.max;
    foreach (ix; 0..N) {
        foreach (jx; ix..N) {
            foreach (iy; 0..N) {
                foreach (jy; iy..N) {
                    if (SS[jy+1][jx+1] - SS[iy][jx+1] - SS[jy+1][ix] + SS[iy][ix] >= K) {
                        auto size = (XS[jx] - XS[ix]) * (YS[jy] - YS[iy]);
                        min_size = min(min_size, size);
                    }
                }
            }
        }
    }
    writeln(min_size);
}