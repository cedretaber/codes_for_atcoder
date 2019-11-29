import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto a = readln.chomp.to!int;
    auto b = readln.chomp.to!int;
    auto h = readln.chomp.to!int;

    writeln((a + b) * h / 2);
}