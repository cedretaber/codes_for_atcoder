import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[5] as;
    foreach (_; 0..N) {
        ++as[readln.chomp.to!int];
    }
    int r = as[4];
    r += min(as[1], as[3]);
    auto r1 = as[1], r3 = as[3];
    as[3] = max(0, as[3] - r1);
    as[1] = max(0, as[1] - r3);
    r += as[3];
    r += as[2]/2;
    if (as[2]%2 == 1) {
        r += 1;
        as[1] = max(0, as[1] - 2);
    }
    r += (as[1]+3)/4;
    writeln(r);
}