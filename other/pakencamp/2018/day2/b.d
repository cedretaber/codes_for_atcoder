import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];
    auto AS = readln.split.to!(int[]);
    sort!"a > b"(AS);
    int s;
    for (int i = D-1; i < N; i += D) {
        s += AS[i];
    }
    writeln(s);
}