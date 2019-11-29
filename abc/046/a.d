import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    readln.chomp.split(" ").sort().uniq.count.writeln;
}