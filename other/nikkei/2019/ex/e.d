import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 1..N+1) {
        auto r = "";
        if (i%2 == 0) r ~= 'a';
        if (i%3 == 0) r ~= 'b';
        if (i%4 == 0) r ~= 'c';
        if (i%5 == 0) r ~= 'd';
        if (i%6 == 0) r ~= 'e';
        if (r == "") {
            writeln(i);
        } else {
            writeln(r);
        }
    }
}