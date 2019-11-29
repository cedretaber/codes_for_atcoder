import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    auto C = readln.chomp.to!int;
    auto D = readln.chomp.to!int;
    auto E = readln.chomp.to!int;

    auto ts = [A, B, C, D, E];
    sort!"(a+9)%10 < (b+9)%10"(ts);
    auto r = ts[0];
    foreach (t; ts[1..$]) {
        r += (t+9)/10*10;
    }
    writeln(r);
}