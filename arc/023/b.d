import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto rcd = readln.split.to!(int[]);
    auto R = rcd[0];
    auto C = rcd[1];
    auto D = rcd[2];
    int r;
    foreach (i; 0..R) {
        foreach (j, a; readln.split.to!(int[])) {
            if (i+j <= D && (i+j)%2 == D%2) {
                r = max(r, a);
            }
        }
    }
    writeln(r);
}