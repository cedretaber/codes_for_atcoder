import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    writeln(readln.to!(wchar[]).count!(c => c == '1'));
}