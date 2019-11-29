import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    foreach (i; 0..S.length-1) if (S[i..i+2] == "AC") {
        writeln("Yes");
        return;
    }
    writeln("No");
}