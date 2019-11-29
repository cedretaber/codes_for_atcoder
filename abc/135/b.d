import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = readln.split.to!(int[]);

    int d;
    foreach (i, p; ps) {
        if (i.to!int+1 != p) ++d;
    }
    writeln(d <= 2 ? "YES" : "NO");
}