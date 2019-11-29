import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!int;
    int r = 1;
    foreach (i; 1..X+1) {
        foreach (j; 2..X+1) {
            if (i^^j <= X) r = max(r, i^^j);
        }
    }
    writeln(r);
}