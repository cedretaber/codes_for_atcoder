import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = readln.split.to!(long[]);
    sort(as);

    auto cs = new long[](10^^5+1);
    foreach (a; as) {
        cs[a] += 1;
    }
    foreach_reverse (i; 0..10^^5) {
        cs[i] += cs[i+1];
    }
    long x, y = 10^^5*2+1;
    while (x+1 < y) {
        auto m = (x+y)/2;
        long c;
        foreach (i; 0..N) {
            auto n = m - as[i];
            if (n < 0) n = 0;
            if (n > 10^^5) continue;
            c += cs[n];
        }
        if (c >= M) {
            x = m;
        } else {
            y = m;
        }
    }
    auto ds = new long[](N);
    foreach_reverse (i; 0..N) {
        if (i+1 < N) ds[i] = ds[i+1];
        ds[i] += as[i];
    }
    long r, c;
    foreach (i; 0..N) {
        if (as[i] + as[0] >= x) {
            r += as[i] * N + ds[0];
            c += N;
        } else if (as[i] + as[N-1] >= x) {
            long a, b = N-1;
            while (a+1 < b) {
                auto m = (a+b)/2;
                if (as[i] + as[m] >= x) {
                    b = m;
                } else {
                    a = m;
                }
            }
            r += as[i] * (N-b) + ds[b];
            c += N-b;
        }
    }
    writeln(r - x*(c-M));
}