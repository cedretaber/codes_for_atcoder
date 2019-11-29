import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto s = readln.chomp.to!(dchar[]);
    foreach (i, c; s) if (i % 2 == 0) write(c);
    writeln("");
}