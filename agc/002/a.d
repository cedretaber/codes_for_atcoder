import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto a = ab[0];
    auto b = ab[1];

    if (a > 0) {
        writeln("Positive");
    } else if (a <= 0 && b >= 0) {
        writeln("Zero");
    } else {
        writeln((b-a+1)%2 == 0 ? "Positive" : "Negative");
    }
}