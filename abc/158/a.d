import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    if (S == "AAA" || S == "BBB") {
        writeln("No");
    } else {
        writeln("Yes");
    }
}