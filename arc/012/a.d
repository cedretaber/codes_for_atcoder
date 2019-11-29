import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum rest = [
    "Monday": 5,
    "Tuesday": 4,
    "Wednesday": 3,
    "Thursday": 2,
    "Friday": 1
];

void main()
{
    auto d = readln.chomp;
    writeln(d in rest ? rest[d] : 0);
}