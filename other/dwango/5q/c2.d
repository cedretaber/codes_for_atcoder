import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto Q = readln.chomp.to!int;
    auto ks = readln.split.to!(int[]);

    foreach (k; ks) {
        long res;
        auto ms = new long[](N);
        long d, m, dm;
        foreach (i, c; S) {
            if (i >= k) {
                if (S[i-k] == 'D') {
                    --d;
                    dm -= ms[i-1] - ms[i-k];
                }
            }
            switch (c) {
                case 'D':
                    ++d;
                    break;
                case 'M':
                    ++m;
                    dm += d;
                    break;
                case 'C':
                    res += dm;
                    break;
                default:
            }
            ms[i] = m;
        }
        writeln(res);
    }
}