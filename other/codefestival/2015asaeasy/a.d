import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 1..101) {
        if (N <= i^^2) {
            writeln(i^^2 - N);
            return;
        }
    }
}