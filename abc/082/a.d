import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto ab = readln.split.to!(float[]);
    writeln(ceil((ab[0] + ab[1]) / 2).to!int);
}