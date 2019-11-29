import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto xab = readln.split.to!(long[]);
    writeln( xab[1] - xab[2] >= 0 ? "delicious" : xab[1] + xab[0] >= xab[2] ? "safe" : "dangerous" );
}