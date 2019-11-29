import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.split.to!(int[]);
    auto N = n[0];
    auto A = n[1];
    auto B = n[2];
    auto C = n[3];
    auto D = n[4];
    writeln(min((N+A-1)/A * B, (N+C-1)/C * D));
}