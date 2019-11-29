import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int i;
    foreach (c; readln.chomp.to!(char[])) {
        if (c == '+') ++i;
        if (c == '-') --i;
    }
    writeln(i);
}