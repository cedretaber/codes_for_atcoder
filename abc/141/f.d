import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(ulong[]);

    int[ulong][2] memo;
    foreach (i, a; AS) {
        if (a !in memo[0]) {
            memo[0][a] = 0;
            memo[1][a] = 0;
        }
        ++memo[i < N/2 ? 0 : 1][a];
    }

    foreach_reverse (i; 0..60) {
        writeln(memo);
        int r, b;
        foreach (a, n; memo[0]) if ((a>>i)&1) foreach (_; 0..n) ++r;
        foreach (a, n; memo[1]) if ((a>>i)&1) foreach (_; 0..n) ++b;

        if (r%2 == 1 || b%2 == 1) continue;

        ulong[ulong] rs1, rs0, bs1, bs0;
        foreach (a, n; memo[0]) if (n > 0) {
            if ((a>>i)&1) {
                rs1[a>>(i+1)] = a;
            } else {
                rs0[a>>(i+1)] = a;
            }
        }
        foreach (a, n; memo[1]) if (n > 0) {
            if ((a>>i)&1) {
                bs1[a>>(i+1)] = a;
            } else {
                bs0[a>>(i+1)] = a;
            }
        }

        if (0 in rs1) {
            auto ra = rs1[0];
            --memo[0][ra];
            ++memo[1][ra];
            continue;
        }
        if (0 in bs1) {
            auto ba = bs1[0];
            --memo[1][ba];
            ++memo[0][ba];
            continue;
        }

        bool ok;
        foreach (top, _; rs1) {
            if (top in bs0) {
                auto ra = rs1[top];
                auto ba = bs0[top];

                --memo[0][ra];
                --memo[1][ba];
                ++memo[0][ba];
                ++memo[1][ra];
                ok = true;
                break;
            }
        }
        if (ok) continue;
        foreach (top, _; bs1) {
            if (top in rs0) {
                auto ra = rs0[top];
                auto ba = bs1[top];

                --memo[0][ra];
                --memo[1][ba];
                ++memo[0][ba];
                ++memo[1][ra];
                break;
            }
        }
    }

    ulong axor, bxor;

    foreach (r, n; memo[0]) foreach (_; 0..n) axor ^= r;
    foreach (b, n; memo[1]) foreach (_; 0..n) bxor ^= b;

    writeln(axor + bxor);
}

/**
23 =>   10111
36 =>  100100
66 => 1000010
65 => 1000001
*/