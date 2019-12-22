import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int max_a;
    foreach (a; readln.split.to!(int[])) {
        if (a == max_a + 1) {
            max_a = a;
        }
    }
    writeln(max_a == 0 ? -1 : (N - max_a));
}