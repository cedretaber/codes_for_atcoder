import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!int;
    for (int i = 1;; ++i) if (i^^4 == X) {
        writeln(i);
        return;
    }
}