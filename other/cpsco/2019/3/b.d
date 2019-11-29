import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto M = nm[1];
    auto as = readln.split.to!(int[]);
    sort!"a > b"(as);
    int r;
    foreach (a; as) {
        if (M <= 0) break;
        ++r;
        M -= a;
    }
    writeln(r);
}