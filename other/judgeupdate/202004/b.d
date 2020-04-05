import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] bs, rs;
    foreach (_; 0..N) {
        auto xc = readln.split;
        auto X = xc[0].to!int;
        auto C = xc[1];
        if (C == "R") {
            rs ~= X;
        } else {
            bs ~= X;
        }
    }
    sort(bs);
    sort(rs);
    foreach (r; rs) writeln(r);
    foreach (b; bs) writeln(b);
}