import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int max_i, max_a = -1;
    foreach (i; 1..N+1) {
        auto a = readln.chomp.to!int;
        if (a > max_a) {
            max_a = a;
            max_i = i;
        }
    }
    writeln(max_i);
}