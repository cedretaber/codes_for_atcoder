import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    long[] HS, SS;
    foreach (_; 0..N) {
        auto hs = readln.split.to!(long[]);
        HS ~= hs[0];
        SS ~= hs[1];
    }

    long l, r = long.max/2;
    while (l+1 < r) {
        auto m = (l+r)/2;
        long[] cs;
        foreach (i; 0..N) {
            if (m < HS[i]) {
                cs ~= -1;
            } else {
                cs ~= (m - HS[i]) / SS[i];
            }
        }
        sort(cs);
        if (cs[0] < 0) {
            l = m;
            continue;
        }
        bool ok = true;
        foreach (i, c; cs) if (i > c) {
            ok = false;
            break;
        }
        if (ok) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}