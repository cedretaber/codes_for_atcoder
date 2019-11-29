import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto P = readln.chomp.to!int;
    int p = 1000;
    auto x = 1789997546303L;
    while (p != P) {
        --p;
        if (x >= 10L^^16) {
            x = 0;
        } else if (x <= 1) {
            x = 0;
        } else if (x%2 == 0) {
            x = x/2;
        } else {
            x = x*3 + 1;
        }
    }
    writeln(x);
}