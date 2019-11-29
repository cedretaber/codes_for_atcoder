import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = readln.split.to!(int[]);

    int[] as, bs;
    as.length = N;
    bs.length = N;
    foreach (int i; 0..N) {
        as[i] = i+1;
        bs[N-i-1] = i+1;
    }
    foreach (dd, p; ps) {
        if (!dd) continue;
        auto d = dd.to!int;
        foreach (i; 0..N) {
            if (i >= p-1) as[i] += d;
            if (i <= p-1) bs[i] += d;
        }
    }

    writeln(as.to!(string[]).join(" "));
    writeln(bs.to!(string[]).join(" "));
}