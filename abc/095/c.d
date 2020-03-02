import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ii = readln.split.to!(long[]);
    auto A = ii[0];
    auto B = ii[1];
    auto C = ii[2];
    auto X = ii[3];
    auto Y = ii[4];

    writeln(min(
        A*X + B*Y,
        C*X*2 + max(0, (Y-X)*B),
        C*Y*2 + max(0, (X-Y)*A)
    ));
}