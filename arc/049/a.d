import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto S = readln.chomp;
    auto ad = readln.split.to!(int[]);
    auto A = ad[0];
    auto B = ad[1];
    auto C = ad[2];
    auto D = ad[3];
    writeln(S[0..A]~"\""~S[A..B]~"\""~S[B..C]~"\""~S[C..D]~"\""~S[D..$]);
}