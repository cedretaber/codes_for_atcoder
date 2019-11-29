import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int sum_p, max_p;
    foreach (_; 0..N) {
        auto p = readln.chomp.to!int;
        sum_p += p;
        max_p = max(max_p, p);
    }
    writeln(sum_p - max_p / 2);
}