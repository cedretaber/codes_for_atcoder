import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto np = readln.split.to!(int[]);
    auto P = np[1];
    auto S = readln.chomp;

    if (P == 2 || P == 5) {
        long r;
        foreach (i, c; S) {
            if ((c-'0') % P == 0) r += i+1;
        }
        writeln(r);
        return;
    }

    auto cs = new long[](P);
    cs[0] = 1;
    long x, t = 1, r;
    foreach_reverse (c; S) {
        x = ((c-'0').to!long * t + x) % P;
        t = (t * 10) % P;
        r += cs[x];
        ++cs[x];
    }
    writeln(r);
}