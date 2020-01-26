import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto H = readln.split.to!(int[])[0];
    foreach (A; readln.split.to!(int[])) H -= A;
    writeln(H <= 0 ? "Yes" : "No");
}