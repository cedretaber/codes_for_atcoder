import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import core.bitop;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = readln.split.to!(long[]);

    auto c = long.max;
    foreach (x; 0..(1<<N)) {
        if (popcnt(x) < K) continue;

        long cc, last;
        foreach (i, a; as) {
            if (a > last) {
                last = a;
            } else if (x & (1<<i)) {
                cc += last - a + 1;
                last += 1;
            }
        }
        c = min(c, cc);
    }
    writeln(c);
}