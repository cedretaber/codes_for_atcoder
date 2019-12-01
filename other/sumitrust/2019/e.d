import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    readln.chomp.to!int;
    int x, y, z;
    long r = 1;
    foreach (a; readln.split.to!(int[])) {
        long d;
        if (a == x) ++d;
        if (a == y) ++d;
        if (a == z) ++d;

        r = (r * d) % P;
        
        if (a == x) {
            ++x;
        } else if (a == y) {
            ++y;
        } else {
            ++z;
        }
    }
    writeln(r);
}