import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto ts = new bool[](N);
    auto as = new int[](M);
    int[] rs;
    foreach (i; 0..M) as[i] = readln.chomp.to!int-1;
    foreach_reverse (a; as) if (!ts[a]) {
        ts[a] = true;
        rs ~= a+1;
    }
    foreach (i, t; ts) if (!t) rs ~= i.to!int+1;
    foreach (r; rs) writeln(r);
}