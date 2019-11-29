import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[50] CITY;

void main()
{
    auto nm = readln.chomp.split(" ").map!(to!int);
    auto n = nm[0];
    auto m = nm[1];

    auto city = CITY[0..n];
    foreach (_i; 0..m) {
        auto ab = readln.chomp.split(" ").map!(to!int);
        ++city[ab[0]-1];
        ++city[ab[1]-1];
    }

    city.each!(writeln);
}