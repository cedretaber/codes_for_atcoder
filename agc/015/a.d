import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto nab = readln.split.to!(long[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];
    writeln(max(0, B*(N-1)+A - (A*(N-1)+B) + 1));
}