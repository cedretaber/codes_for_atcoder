import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    sort!"a > b"(AS);
    long fst, bf;
    foreach (a; AS) {
        if (!bf) {
            bf = a;
            continue;
        }
        if (!fst && bf == a) {
            fst = a;
            bf = 0;
            continue;
        }
        if (bf == a) {
            writeln(fst * a);
            return;
        }
        bf = a;
    }
    writeln(0);
}