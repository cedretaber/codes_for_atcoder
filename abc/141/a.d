import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum next = [
    "Sunny": "Cloudy",
    "Cloudy": "Rainy",
    "Rainy": "Sunny"
];

void main()
{
    writeln(next[readln.chomp]);
}