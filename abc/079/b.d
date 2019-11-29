import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

long[] make_lucas()
{
    long[] ls = [2,1];
    for (int i = 2; i < 87; ++i) {
        ls ~= ls[i-1] + ls[i-2];
    }
    return ls;
}

enum LS = make_lucas();

void main()
{
    writeln(LS[readln.chomp.to!int]);
}