import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    long M = nm[1];
    long[] PS = [0];
    foreach (_; 0..N) PS ~= readln.chomp.to!long;

    long[] QS;
    foreach (i; 0..N+1) {
        foreach (j; i..N+1) {
            QS ~= PS[i] + PS[j];
        }
    }
    sort(QS);
    
    long res;
    foreach (q; QS) {
        if (q + QS[0] > M) {
            continue;
        } else if (q + QS[$-1] <= M) {
            res = max(res, q + QS[$-1]);
            continue;
        }

        size_t l, r = QS.length - 1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (q + QS[m] > M) {
                r = m;
            } else {
                l = m;
            }
        }
        res = max(res, q + QS[l]);
    }
    writeln(res);
}