import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto LS = readln.split.to!(int[]);

    sort!"a > b"(LS);
    auto l = LS[0];
    auto sum_l = reduce!"a + b"(0, LS[1..$]);
    writeln(l < sum_l ? "Yes" : "No");
}