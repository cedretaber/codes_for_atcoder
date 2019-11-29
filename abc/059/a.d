import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    readln.chomp.split(" ").map!(s => s.capitalize.array[0]).array.writeln;
}