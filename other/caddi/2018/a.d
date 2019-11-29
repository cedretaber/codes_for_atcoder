import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int n;
    foreach (c; readln.chomp) if (c == '2') ++n;
    writeln(n);
}