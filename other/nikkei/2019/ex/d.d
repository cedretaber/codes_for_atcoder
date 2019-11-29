import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto r = "1";
    foreach (_; 0..N-1) r ~= '0';
    writeln(r);
}