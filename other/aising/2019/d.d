import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto AS = readln.split.to!(long[]);

    auto CS = new long[](N);
    auto DS = new long[](N);
    auto ES = new long[](N);
    foreach (i; 0..N) {
        if (i > 0) CS[i] += CS[i-1];
        CS[i] += AS[i];
        if (i-2 >= 0) DS[i] += DS[i-2];
        DS[i] += AS[i];
    }

    foreach (_; 0..Q) {
        auto X = readln.chomp.to!long;
        if (X <= AS[0]) {
            writeln(CS[N-1] - CS[N/2-1]);
            continue;
        } else if (X >= AS[N-1]) {
            writeln(DS[N-1]);
            continue;
        }
        int l, r = N-1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (AS[m] - X <= 0) {
                l = m;
            } else {
                r = m;
            }
        }
        int i = abs(AS[l] - X) <= abs(AS[r] - X) ? l : r;
        if (i == N-1 || i == N-2) {
            writeln(DS[N-1]);
            continue;
        }

        l = i, r = N-2;
        while (l+1 < r) {
            auto m = (l+r)/2;
            auto t = N - m - 1;
            auto a = m - i + 1;
            auto d = abs(AS[m] - X);
            if (abs(AS[0] - X) <= d) {
                a = m + 1;
            } else {
                int ll, rr = i;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (abs(AS[mm] - X) <= d) {
                        rr = mm;
                    } else {
                        ll = mm;
                    }
                }
                a += i - rr;
            }
            if (t >= a) {
                l = m;
            } else {
                r = m;
            }
        }
        auto res = CS[N-1] - CS[l];
        auto n = N - (N - r) * 2 - 1;
        if (n >= 0) res += DS[n];
        writeln(res);
    }
}