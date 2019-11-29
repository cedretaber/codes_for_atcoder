import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto a = readln.chomp.to!int;
    auto b = readln.chomp.to!int;
    auto c = readln.chomp.to!int;
    auto d = readln.chomp.to!int;
    auto e = readln.chomp.to!int;
    auto k = readln.chomp.to!int;

    auto ts = [a, b, c, d, e];
    foreach (i; 0..5) {
        foreach (j; i+1..5) {
            if (ts[j] - ts[i] > k) {
                writeln(":(");
                return;
            }
        }
    }
    writeln("Yay!");
}