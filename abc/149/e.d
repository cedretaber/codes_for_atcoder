import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = readln.split.to!(long[]);
    sort!"a > b"(as);
    auto cs = new long[](N);
    foreach_reverse (i; 0..N) {
        if (i+1 < N) cs[i] = cs[i+1];
        cs[i] += as[i];
    }

    long r;
    foreach (i; 0..N) {
        auto k = (N-i)*2 - 1;
        if (M >= k) {
            r += as[i] * (k+1);
            if (i+1 < N) r += cs[i+1] * 2;
            M -= k;
        } else {
            if (M == 0) break;
            r += as[i]*2;
            M -= 1;
            foreach (j; i+1..N) {
                if (M == 0) {
                    break;
                } else if (M == 1) {
                    r += as[i] + as[j];
                    M = 0;
                } else {
                    r += (as[i] + as[j]) * 2;
                    M -= 2;
                }
            }
        }
    }
    writeln(r);
}