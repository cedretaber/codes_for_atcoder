import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int t_max;
    foreach (_; 0..8) {
        t_max = max(t_max, readln.chomp.to!int);
    }
    writeln(t_max);
}