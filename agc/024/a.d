import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto abck = readln.split.to!(long[]);
    auto A = abck[0];
    auto B = abck[1];
    auto K = abck[3];

    writeln(K&1 ? B - A : A - B);
}