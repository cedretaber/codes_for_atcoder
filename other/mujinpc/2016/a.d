import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto c = readln.chomp;
    if (c == "O" || c == "K" || c == "P" || c == "L") {
        writeln("Right");
    } else {
        writeln("Left");
    }
}