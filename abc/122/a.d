import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto b = readln.chomp.to!(char);
    switch (b) {
        case 'A':
            writeln("T");
            return;
        case 'T':
            writeln("A");
            return;
        case 'C':
            writeln("G");
            return;
        case 'G':
            writeln("C");
            return;
        default:
            return;
    }
}