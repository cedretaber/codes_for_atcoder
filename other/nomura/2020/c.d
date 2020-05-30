import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    if (N == 0) {
        writeln(AS[0] == 1 ? 1 : -1);
        return;
    }

    long r, c = 1;
    long[] BS;
    foreach (a; AS) {
        r += a;
        c -= a;
        if (c < 0) {
            writeln(-1);
            return;
        }
        BS ~= c;
        if (c <= c*2) {
            c *= 2;
        } else {
            c = 10L^^18;
        }
    }

    long d;
    foreach_reverse (i, a; AS[1..$]) {
        d = min(d + a, BS[i]);
        r += d;
    }

    writeln(r);
}