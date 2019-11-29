import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    auto PS = readln.split.to!(int[]);

    int a, b, c;
    foreach (p; PS) {
        if (p <= A) {
            ++a;
        } else if (p <= B) {
            ++b;
        } else {
            ++c;
        }
    }
    writeln(min(a, b, c));
}