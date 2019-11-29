import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto a123 = readln.split.to!(int[]);

    sort(a123);

    int cst;
    for (int i = 0; i < 2; ++i) {
        cst += abs(a123[i] - a123[i+1]);
    }
    writeln(cst);
}