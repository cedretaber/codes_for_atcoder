import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    if (N == 1) {
        writeln(1);
    } else {
        writeln((3.5 * N).to!int);
    }
}