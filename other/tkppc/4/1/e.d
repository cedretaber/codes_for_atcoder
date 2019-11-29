import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmke = readln.split.to!(int[]);
    auto K = nmke[2];
    long E = nmke[3];
    auto AS = readln.split.to!(long[]);
    sort(AS);
    auto BS = readln.split.to!(long[]);
    sort!"a > b"(BS);

    size_t j;
    foreach (i, a; AS) {
        while (a > E) {
            if (j < K) {
                E += BS[j++];
            } else {
                writeln("No");
                writeln(i);
                return;
            }
        }
        E -= a;
    }
    writeln("Yes");
    writeln(j);
}