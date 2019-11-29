import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto x = readln.split.to!(long[]);
    writeln((((x[0] * x[1]) % P) * x[2]) % P);
}