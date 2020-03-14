import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(long[]);
    auto a = abc[0];
    auto b = abc[1];
    auto c = abc[2];

    if (c-a-b > 0 && 4*a*b < (c-a-b)^^2L) {
        writeln("Yes");
    } else {
        writeln("No");
    }
}