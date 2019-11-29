import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

void main()
{
    auto n = readln.chomp.to!int;
    int min, max = -1;
    foreach (_; 0..n) {
        auto ab = readln.split.to!(int[]);
        if (ab[0] > max) {
            max = ab[0];
            min = ab[1];
        }
    }
    writeln(max + min);
}