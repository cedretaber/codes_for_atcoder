import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!long;
    long x = 100;
    foreach (t; 1..10000) {
        x = (x.to!double * 1.01).to!long;
        if (x >= X) {
            writeln(t);
            return;
        }
    }
}