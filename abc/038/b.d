import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw1 = readln.split.to!(int[]);
    auto hw2 = readln.split.to!(int[]);
    writeln(hw1[0] == hw2[0] || hw1[1] == hw2[0] || hw1[0] == hw2[1] || hw1[1] == hw2[1] ? "YES" : "NO");
}