import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    long X = nx[1];
    auto TS = new long[](N);
    long sum_t;
    foreach (i; 0..N) TS[i] = readln.chomp.to!long;
    foreach_reverse (i; 0..N) {
        if (i) TS[i] -= TS[i-1];
        TS[i] = min(TS[i], X);
        sum_t += TS[i];
    }
    sum_t -= TS[0];
    TS[0] = X;
    sum_t += X;

    long[] TS2, res = [sum_t];
    foreach (_; 1..N) {
        size_t x;
        long min_t = long.max;
        foreach (i; 0..TS.length-1) {
            if (TS[i] + TS[i+1] < min_t) {
                x = i;
                min_t = TS[i] + TS[i+1];
            }
        }
        TS2.length = TS.length-1;
        sum_t = 0;
        for (size_t i, j; i < TS.length; ++i, ++j) {
            if (i == x) {
                TS2[j] = min(X, TS[i] + TS[i+1]);
                ++i;
            } else {
                TS2[j] = TS[i];
            }
            sum_t += TS2[j];
        }
        res ~= sum_t;
        TS = TS2;
    }
    foreach_reverse (r; res) {
        writeln(r);
    }
}