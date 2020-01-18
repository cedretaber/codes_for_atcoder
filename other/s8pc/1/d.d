import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;
long[10^^5+50] F, RF;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long inv(long x)
{
    return pow(x, P-2);
}

void init()
{
    F[0] = F[1] = 1;
    foreach (i, ref x; F[2..$]) x = (F[i+1] * (i+2)) % P;

    {
        RF[$-1] = 1;
        auto x = F[$-1];
        auto k = P-2;
        while (k) {
            if (k%2 == 1) RF[$-1] = (RF[$-1] * x) % P;
            x = x^^2 % P;
            k /= 2;
        }
    }
    foreach_reverse(i, ref x; RF[0..$-1]) x = (RF[i+1] * (i+1)) % P;
}

alias Point = Tuple!(long, "x", long, "y");


long comb(long x1, long y1, long x2, long y2)
{
    auto a = x2 - x1;
    auto b = y2 - y1;
    if (a < 0 || b < 0) return 0;
    if (a == 0 || b == 0) return 1;
    return ((F[a + b] * RF[a]) % P * RF[b]) % P;
}

void main()
{
    init();
    auto hwk = readln.split.to!(int[]);
    long H = hwk[0];
    long W = hwk[1];
    auto K = hwk[2];
    Point[] ps;
    foreach (_; 0..K) {
        auto xy = readln.split.to!(long[]);
        ps ~= Point(xy[0], xy[1]);
    }
    sort(ps);
    long a, b;
    foreach (i, p; ps) {
        long c, d;
        if (i == 0) {
            c = comb(1, 1, p.x+1, p.y);
            d = comb(1, 1, p.x, p.y+1);
        } else {
            foreach (dd; [[1,0,a], [0,1,b]]) {
                auto x = ps[i-1].x+dd[0];
                auto y = ps[i-1].y+dd[1];
                auto f = dd[2];
                c = (c + (comb(x, y, p.x+1, p.y) * f) % P) % P;
                d = (d + (comb(x, y, p.x, p.y+1) * f) % P) % P;
            }
        }
        a = c;
        b = d;
    }
    long r;
    foreach (dd; [[1,0,a], [0,1,b]]) {
        auto x = ps[$-1].x+dd[0];
        auto y = ps[$-1].y+dd[1];
        auto c = dd[2];
        r = (r + (comb(x, y, W, H) * c) % P) % P;
    }
    writeln(r);
}