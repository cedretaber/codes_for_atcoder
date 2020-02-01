import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    int s;
    foreach (i; 0..200) {
        auto j = i%20;
        auto k = i/20;
        if ((k%2 == 0 && j == T-1) || (k%2 == 1 && j == 20-T)) {
            s += i+1;
        }
    }
    writeln(s);
}