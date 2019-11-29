import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

void main()
{
    auto abcd = readln.split.to!(long[]);
    auto ab = abcd[0] * abcd[1];
    auto cd = abcd[2] * abcd[3];

    writeln( ab > cd ? ab : cd );
}