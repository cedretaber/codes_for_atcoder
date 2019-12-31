import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmvp = readln.split.to!(long[]);
    auto N = nmvp[0];
    auto M = nmvp[1];
    auto V = nmvp[2];
    auto P = nmvp[3];
    auto as = readln.split.to!(long[]);
    sort!"a > b"(as);

    bool check(long i) {
        auto a = as[i] + M;
        if (as[P-1] > a) return false;

        auto x = (V - P + 1 - N + i) * M;
        if (x <= 0) return true;

        foreach (j; P-1..i) {
            x -= min(M, a - as[j]);
            if (x <= 0) break;
        }

        return x <= 0;
    }

    if (check(N-1)) {
        writeln(N);
        return;
    }

    long l = P-1, r = N-1;
    while (l+1 < r) {
        auto m = (l+r)/2;
        if (check(m)) {
            l = m;
        } else {
            r = m;
        }
    }
    writeln(r);
}