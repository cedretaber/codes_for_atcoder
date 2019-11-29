import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abx = readln.split.to!(long[]);
    auto A = abx[0];
    auto B = abx[1];
    auto X = abx[2];

    if (A*10L^^9L + B*10L <= X) {
        writeln(10L^^9);
        return;
    }

    long res;
    foreach (long k; 1..10) {
        if (A*(10L^^(k-1)) + B*k > X) continue;
        if (A*(10L^^k-1) + B*k <= X) {
            res = max(res, 10L^^k-1);
            continue;
        }
        long l = 10L^^(k-1), r = 10L^^k-1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (m*A + k*B > X) {
                r = m;
            } else {
                l = m;
            }
        }
        res = max(res, l);
    }
    writeln(res);
}