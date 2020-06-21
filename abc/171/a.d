import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto a = readln[0];
    switch (a) {
        case 'A': .. case 'Z':
            writeln("A");
            return;
        default:
            writeln("a");
            return;
    }
}