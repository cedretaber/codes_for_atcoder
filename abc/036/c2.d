import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] as, bs;
    foreach (_; 0..N) {
        auto a = readln.chomp.to!int;
        as ~= a;
        bs ~= a;
    }
    sort(bs);
    bs = bs.uniq.array;
    int[int] atoi;
    foreach (i, b; bs) atoi[b] = i.to!int;
    foreach (a; as) writeln(atoi[a]);
}