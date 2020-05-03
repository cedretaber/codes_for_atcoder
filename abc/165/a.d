import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto k = readln.chomp.to!int;
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    auto x = k;
    while (x <= B) {
        if (x >= A) {
            writeln("OK");
            return;
        }
        x += k;
    }
    writeln("NG");
}