import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    readln;
    auto N = nk[0];
    auto K = nk[1];
    int c;
    while (N > 1) {
        ++c;
        N -= K-1;
    }
    writeln(c);
}