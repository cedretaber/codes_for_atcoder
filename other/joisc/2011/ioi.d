import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto knm = readln.split.to!(int[]);
    auto K = knm[0];
    auto N = knm[1];
    auto M = knm[2];

    auto b = (K+11)/12;
    auto max_p = (N-M) * 100;

    long[] ps;
    foreach (_; 0..K) {
        ps ~= readln.chomp.to!int;
    }
    auto min_ps = ps.dup;
    sort!"a > b"(min_ps);

    if (N == M) {
        int[] ii;
        foreach (i; 0..K) {
            auto p = ps[i];
            if (min_ps[b-1] <= p) ii ~= i+1;
        }
        foreach (i; ii) writeln(i);
        writeln("--------");
        foreach (i; ii) writeln(i);
        return;
    }

    auto max_ps = min_ps.map!(p => p + max_p).array;

    int[] sure, maybe;
    foreach (i; 0..K) {
        auto p = ps[i];
        {
            int l, r = K;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (max_ps[m] > p) {
                    l = m;
                } else {
                    r = m;
                }
            }
            if (r <= b) {
                sure ~= i+1;
            }
        }

        if (min_ps[0] <= p+max_p) {
            maybe ~= i+1;
        } else {
            int l, r = K;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (min_ps[m] > p+max_p) {
                    l = m;
                } else {
                    r = m;
                }
            }
            if (r+1 <= b) {
                maybe ~= i+1;
            }
        }
    }

    foreach (ref s; sure) writeln(s);
    writeln("--------");
    foreach (ref m; maybe) writeln(m);
}