import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;


void main()
{
    auto N = readln.chomp.to!int;
    auto ds = new int[](N);

    int max_d, min_d, md;

    foreach (i; 0..N) {
        auto d = readln.chomp.to!int;
        max_d += d;
        md = max(md, d);
        ds[i] = d;
    }

    if (N == 1) {
        min_d = ds[0];
    } else {
        min_d = max(0, -(max_d - md*2));
    }
    writeln(max_d);
    writeln(min_d);
}