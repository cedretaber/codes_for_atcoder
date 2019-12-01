import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!double;
    foreach (i; 0..50000+1) {
        if ((i * 1.08).to!int == N) {
            writeln(i);
            return;
        }
    }
    writeln(":(");
}