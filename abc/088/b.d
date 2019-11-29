import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    readln;
    auto AS = readln.split.to!(int[]);
    AS.sort!"a > b";

    int A, B;
    foreach (i, a; AS) {
        if (i&1)
            B += a;
        else
            A += a;
    }
    writeln(A - B);
}