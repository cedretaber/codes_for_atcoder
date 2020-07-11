import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range, core.bitop;

void main()
{
    auto PP = new long[](10^^5*2+1);
    foreach (i; 1..10^^5*2+1) {
        PP[i] = PP[i % popcnt(i)] + 1;
    }
    auto N = readln.chomp.to!int;
    auto X = readln.chomp;
    long bc;
    foreach (b; X) if (b == '1') ++bc;
    auto cs = new long[][](N, 2);
    auto xs = new long[][](N, 2);
    long x1 = 1, x2 = 1;
    foreach_reverse (i, b; X) {
        if (i != N-1) {
            cs[i][0] = cs[i+1][0];
            cs[i][1] = cs[i+1][1];
        }
        if (b == '1') {
            if (bc > 1) (cs[i][0] += x1) %= (bc-1);
            (cs[i][1] += x2) %= (bc+1);
        }
        xs[i][0] = x1;
        xs[i][1] = x2;
        if (bc > 1) (x1 *= 2) %= (bc-1);
        (x2 *= 2) %= (bc+1);
    }
    x1 = 0;
    x2 = 0;
    foreach (i, b; X) {
        if (b == '1') {
            if (bc == 1) {
                writeln(0);
            } else {
                auto n = x1 + (i == N-1 ? 0 : cs[i+1][0]);
                writeln(PP[n % (bc-1)] + 1);
            }
            if (bc > 1) (x1 += xs[i][0]) %= (bc-1);
            (x2 += xs[i][1]) %= (bc+1);
        } else {
            auto n = x2 + xs[i][1] + (i == N-1 ? 0 : cs[i+1][1]);
            writeln(PP[n % (bc+1)] + 1);
        }
    }
}