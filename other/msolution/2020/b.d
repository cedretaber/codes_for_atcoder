import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto abc = readln.split.to!(int[]);
    auto A = abc[0];
    auto B = abc[1];
    auto C = abc[2];
    auto K = readln.chomp.to!int;

    int k;
    while (B <= A) {
        ++k;
        B *= 2;
    }
    while (C <= B) {
        ++k;
        C *= 2;
    }
    writeln(k <= K ? "Yes" : "No");
}