import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias MP = Tuple!(int, "i", int, "p");

int[11] PS, CS;

void main()
{
    auto dg = readln.split.to!(int[]);
    auto D = dg[0];
    auto G = dg[1] / 100;

    foreach (i; 1..D+1) {
        auto pc = readln.split.to!(int[]);
        PS[i] = pc[0];
        CS[i] = pc[1] / 100;
    }

    int solve(int i, int c, uint m) {
        if (i == D+1) {
            foreach_reverse (j; 1..D+1) {
                if (m & (1<<j)) continue;
                if (c >= PS[j]) continue;
                return j * c;
            }
            return 0;
        }

        auto r1 = solve(i + 1, c, m);
        if (c >= PS[i]) {
            auto r2 = PS[i] * i + CS[i] + solve(i + 1, c - PS[i], m | (1<<i));
            return max(r1, r2);
        } else {
            return r1;
        }
    }

    foreach (i; 1..1001) {
        if (solve(1, i, 0) >= G) {
            writeln(i);
            return;
        }
    }
}