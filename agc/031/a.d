import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9 + 7;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);

    long[26] as;

    foreach (c; S) {
        if (as[c-97] == 0) {
            as[c-97] = 2;
        } else {
            ++as[c-97];
        }
    }

    long r = 1;
    foreach (a; as) if (a) {
        r = (r * a) % P;
    }
    writeln(r-1);
}