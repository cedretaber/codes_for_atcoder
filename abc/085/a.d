import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto s = readln.chomp.to!(dchar[]);
    s[3] = '8';
    writeln(s);
}