import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ks = readln.split.to!(int[]);
    auto res = new int[](N);
    res[0] = ks[0];
    foreach (i; 1..N-1) {
        res[i] = min(ks[i-1], ks[i]);
    }
    res[N-1] = ks[$-1];
    writeln(res.to!(string[]).join(" "));
}