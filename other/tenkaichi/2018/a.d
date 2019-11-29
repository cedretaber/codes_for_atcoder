import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto S = readln.chomp.to!(char[]);
    if (S.length == 3) S.reverse();
    writeln(S);
}