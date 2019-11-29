import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto R = readln.chomp.to!int;
    if (R < 1200) {
        writeln("ABC");
    } else if (R < 2800) {
        writeln("ARC");
    } else {
        writeln("AGC");
    }
}