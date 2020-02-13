import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto N = readln.chomp.to!int;
    uint[] ss;
    foreach (_; 0..N) {
        uint s;
        foreach (i, f; readln.split) if (f == "1") s |= (1<<i);
        ss ~= s;
    }
    long[][] ps;
    foreach (_; 0..N) ps ~= readln.split.to!(long[]);

    long r = long.min;
    foreach (uint j; 1..(1<<10)) {
        long rr;
        foreach (i; 0..N) rr += ps[i][popcnt(j & ss[i])];
        r = max(r, rr);
    }
    writeln(r);
}