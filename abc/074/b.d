import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto K = readln.chomp.to!int;
    
    int sum_t;
    foreach (x; readln.split.to!(int[])) {
        auto a = x * 2;
        auto b = abs(x - K) * 2;
        sum_t += min(a, b);
    }
    writeln(sum_t);
}