import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum R = [
    "SUN": 7,
    "MON": 6,
    "TUE": 5,
    "WED": 4,
    "THU": 3,
    "FRI": 2,
    "SAT": 1
];

void main()
{
    writeln(R[readln.chomp]);
}