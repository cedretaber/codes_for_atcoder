import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto AS = readln.split.to!(long[]);
    auto SS = readln.split.to!(long[]);

    auto CS = new long[](N);
    CS[0] = AS[0];
    foreach (i; 1..N) CS[i] = gcd(CS[i-1], AS[i]);

    foreach (X; SS) {
        if (gcd(X, CS[N-1]) != 1) {
            writeln(gcd(X, CS[N-1]));
        } else if (gcd(X, CS[0]) == 1) {
            writeln(1);
        } else {
            int l, r = N-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (gcd(X, CS[m]) == 1) {
                    r = m;
                } else {
                    l = m;
                }
            }
            writeln(r+1);
        }
    }
}