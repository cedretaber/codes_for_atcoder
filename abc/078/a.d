import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto x_y = readln.to!(wchar[]);
    writeln(x_y[0] > x_y[2] ? ">" : x_y[0] < x_y[2] ? "<" : "=");
}