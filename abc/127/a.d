import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    if (A >= 13) {
        writeln(B);
    } else if (A >= 6) {
        writeln(B/2); 
    } else {
        writeln(0);
    }
}