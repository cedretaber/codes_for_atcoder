import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.split.to!(int[])[3];
    auto AS = readln.split.to!(long[]);
    auto BS = readln.split.to!(long[]);
    auto CS = readln.split.to!(long[]);

    long[] abs, rs;
    foreach (a; AS) foreach (b; BS) abs ~= a + b;
    sort!"a > b"(abs);
    foreach (c; CS) foreach (d; abs[0..min(abs.length, K)]) rs ~= c + d;
    sort!"a > b"(rs);
    foreach (r; rs[0..K]) writeln(r);
}