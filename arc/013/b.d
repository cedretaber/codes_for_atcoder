import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto C = readln.chomp.to!int;
    int n, m, l;
    foreach (_; 0..C) {
        auto nml = readln.split.to!(int[]);
        sort(nml);
        n = max(n, nml[0]);
        m = max(m, nml[1]);
        l = max(l, nml[2]);
    }
    writeln(n*m*l);
}