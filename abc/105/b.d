import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    for (int a = 0; a * 4 <= 100; ++a) {
        for (int b = 0; b * 7 <= 100; ++b) {
            if (a * 4 + b * 7 == N) {
                writeln("Yes");
                return;
            }
        }
    }
    writeln("No");
}