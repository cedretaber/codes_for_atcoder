import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto y = readln.chomp.to!int;
    auto m = readln.chomp.to!int;
    auto d = readln.chomp.to!int;

    if (m == 1) {
        y -= 1;
        m = 13;
    } else if (m == 2) {
        y -= 1;
        m = 14;
    }
    auto x = 365*y + y/4 - y/100 + y/400 + ((m+1)*306)/10 + d - 429;
    writeln(735369 - x);
}