import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    char[] r = ['1'];
    foreach (_; 0..N) r ~= '0';
    r[$-1] = '7';
    writeln(r);
}