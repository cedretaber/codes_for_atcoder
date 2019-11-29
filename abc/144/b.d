import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..10) {
        foreach (j; i..10) {
            if (N == i*j) {
                writeln("Yes");
                return;
            }
        }
    }
    writeln("No");
}