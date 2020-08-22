import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    long s, last;
    foreach (a; readln.split.to!(long[])) {
        if (a >= last) {
            last = a;
        } else {
            s += last - a;
        }
    }
    writeln(s);
}