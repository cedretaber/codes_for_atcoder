import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nr = readln.split.to!(int[]);
    auto N = nr[0];
    auto R = nr[1];
    if (N >= 10) {
        writeln(R);
    } else {
        writeln(R + 100 * (10-N));
    }
}