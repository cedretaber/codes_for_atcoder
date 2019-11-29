import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    long b;
    foreach (i, a; AS) {
        if (i%2 == 0) {
            b += a;
        } else {
            b -= a;
        }
    }
    long[] r = [b];
    auto c = b;
    foreach (a; AS[0..$-1]) {
        c = (a-c/2)*2;
        r ~= c;
    }
    writeln(r.map!(i => i.to!string).join(" "));
}