import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto abc = readln.split.to!(int[]);
        auto A = abc[0];
        auto B = abc[1];
        auto C = abc[2];

        if (C%2 == 1) {
            writeln("No");
            continue;
        }
        if (B%2 == 1 && C < 10) {
            writeln("No");
            continue;
        }
        B += C/10;
        if (A%2 == 1 && B < 10) {
            writeln("No");
            continue;
        }
        writeln("Yes");
    }
}