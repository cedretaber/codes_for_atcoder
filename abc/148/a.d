import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    if (A + B == 5) {
        writeln(1);
    } else if (A + B == 4) {
        writeln(2);
    } else if (A + B == 3) {
        writeln(3);
    }
}