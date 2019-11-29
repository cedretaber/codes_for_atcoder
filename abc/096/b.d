import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto abc = readln.split.to!(int[]);
    auto K = readln.chomp.to!int;

    auto max = abc.reduce!max;

    writeln(abc.sum - max + max*2^^K);
}