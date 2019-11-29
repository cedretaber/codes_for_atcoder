import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    int ret;
    foreach (_; 0..N) {
        auto lr = readln.split.to!(int[]);
        ret += lr[1] - lr[0] + 1;
    }
    writeln(ret);
}