import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp;
    foreach (c; N) if (c == '7') {
        writeln("Yes");
        return;
    }
    writeln("No");
}