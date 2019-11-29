import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(long[]);
    sort(abc);
    auto A = abc[0];
    auto B = abc[1];
    auto C = abc[2];

    if (A%2 == 0 || B%2 == 0 || C%2 == 0) {
        writeln(0);
    } else {
        writeln(A * B);
    }
}