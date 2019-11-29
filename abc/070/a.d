import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto line = readln.chomp;
    auto enil = line.dup;
    reverse(enil);
    writeln(line == enil ? "Yes" : "No");
}