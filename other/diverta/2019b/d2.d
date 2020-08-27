import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!long;
    auto AS = readln.split.to!(long[]);
    auto BS = readln.split.to!(long[]);

    long solve(long N, long[] XS, long[] YS) {
        int[] ps;
        foreach (i; 0..3) if (XS[i] < YS[i]) ps ~= i;

        if (ps.length == 1) {
            auto i = ps[0];
            N = N/XS[i]*YS[i] + N%XS[i];
        } else if (ps.length == 2) {
            auto i = ps[0];
            auto j = ps[1];

            auto n = N;
            foreach (x; 0..N/XS[i]+1) {
                auto nn = N - x*XS[i];
                n = max(n, x*YS[i] + nn/XS[j]*YS[j] + nn%XS[j]);
            }
            N = n;
        } else if (ps.length == 3) {
            auto n = N;
            foreach (x; 0..N/XS[0]+1) {
                auto nn = N - x*XS[0];
                foreach (y; 0..nn/XS[1]+1) {
                    auto nnn = nn - y*XS[1];
                    auto z = nnn/XS[2];
                    n = max(n, x*YS[0] + y*YS[1] + z*YS[2] + nnn%XS[2]);
                }
            }
            N = n;
        }
        return N;
    }
    writeln(solve(solve(N, AS, BS), BS, AS));
}