import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto S = readln.chomp;
    char[] ts, ds;
    foreach (_; 0..Q) {
        auto td = readln;
        ts ~= td[0];
        ds ~= td[2];
    }
    int i, j = N-1;
    foreach_reverse (k; 0..Q) {
        auto t = ts[k];
        auto d = ds[k];
        if (d == 'L') {
            if (i < N && S[i] == t) ++i;
            if (j < N-1 && S[j+1] == t) ++j;
        } else {
            if (j >= 0 && S[j] == t) --j;
            if (i > 0 && S[i-1] == t) --i;
        }
    }
    writeln(max(0, j - i + 1));
}