import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    auto LS = readln.split.to!(int[]);

    int d, c;
    foreach (l; LS) {
        ++c;
        d += l;
        if (d > X) break;
    }
    if (d <= X) ++c;
    writeln(c);
}