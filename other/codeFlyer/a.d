import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;

    auto c = B;
    while (c <= A)
        c += B;
    writeln(c - B);
}
