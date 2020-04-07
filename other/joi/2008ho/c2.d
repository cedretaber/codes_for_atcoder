import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    long M = nm[1];
    long[] ps = [0];
    foreach (i; 0..N) {
        ps ~= readln.chomp.to!long;
    }
    foreach (i; 1..N+1) {
        foreach (j; i..N+1) {
            ps ~= ps[i] + ps[j];
        }
    }
    sort(ps);
    long max_p;
    foreach (p; ps) {
        if (p + ps[0] > M) {
            continue;
        } else if (p + ps[$-1] <= M) {
            max_p = max(max_p, p + ps[$-1]);
        } else {
            size_t l, r = ps.length-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (p + ps[m] <= M) {
                    l = m;
                } else {
                    r = m;
                }
            }
            max_p = max(max_p, p + ps[l]);
        }
    }
    writeln(max_p);
}