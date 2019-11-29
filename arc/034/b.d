import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!long;

    long[] r;
    long[10] ns;
    void solve(int i, int n) {
        if (i == 18) {
            long s;
            foreach (j, m; ns) s += m * j;
            auto d = N - s;
            if (d < 0) return;
            long[10] ms;
            int c;
            while (d) {
                ++ms[d%10];
                d /= 10;
                ++c;
            }
            ms[0] += 18-c;
            if (ns == ms) r ~= N - s;
        } else {
            if (n != 9) solve(i, n+1);
            ++ns[n];
            solve(i+1, n);
            --ns[n];
        }
    }
    solve(0, 0);
    writeln(r.length);
    foreach (rr; r) writeln(rr);
}