import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto abc = readln.split.to!(int[]);
    sort(abc);
    auto a = abc[0];
    auto b = abc[1];
    auto c = abc[2];

    writeln(c-b + (b-a+1)/2 + (b-a)%2);
}