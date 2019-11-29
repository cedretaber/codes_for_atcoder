import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range;

void main()
{
    0.iota(readln.chomp.to!int+1).reduce!"a+b".writeln;
}