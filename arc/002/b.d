import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;
import std.datetime, core.time;

void main()
{
    auto ymd = readln.chomp.split("/").to!(int[]);
    auto d = Date(ymd[0], ymd[1], ymd[2]);

    while (d.year % d.month != 0 || (d.year / d.month) % d.day != 0) d += 1.days;
    writefln("%04d/%02d/%02d", d.year, d.month, d.day);
}