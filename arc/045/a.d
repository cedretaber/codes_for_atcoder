import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum AT = [
    "Left": "<",
    "Right": ">",
    "AtCoder": "A"
];

void main()
{
    auto S = readln.split;
    writeln(S.map!(c => AT[c]).array.join(" "));
}