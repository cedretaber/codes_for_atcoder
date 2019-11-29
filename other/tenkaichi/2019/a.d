import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(int[]);
    auto A = abc[0];
    auto B = abc[1];
    auto C = abc[2];
    writeln((A < C && C < B) || (B < C && C < A) ? "Yes" : "No");
}