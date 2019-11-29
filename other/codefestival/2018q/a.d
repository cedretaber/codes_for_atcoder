import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    auto C = readln.chomp.to!int;
    auto S = readln.chomp.to!int;
    writeln(A+B+C <= S && S <= A+B+C+3 ? "Yes" : "No");
}