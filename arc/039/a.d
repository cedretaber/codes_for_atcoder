import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto ab = readln.split.to!(char[][]);
    auto a = ab[0];
    auto A = a.to!int;
    auto b = ab[1];
    auto B = b.to!int;

    foreach (i; 0..3) {
        if (a[i] != '9') {
            a[i] = '9';
            break;
        }
    }
    auto r1 = a.to!int - B;

    if (b[0] != '1') {
        b[0] = '1';
    } else if (b[1] != '0') {
        b[1] = '0';
    } else {
        b[2] = '0';
    }
    auto r2 = A - b.to!int;

    writeln(max(r1, r2));
}