import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    if (N == 1) {
        writeln("Hello World");
    } else {
        auto A = readln.chomp.to!int;
        auto B = readln.chomp.to!int;
        writeln(A + B);
    }
}