import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto A = readln.chomp.to!int;

    writeln(N % 500 <= A ? "Yes" : "No");
}