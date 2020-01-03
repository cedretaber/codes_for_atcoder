import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = new int[](2^^N);
    foreach (i; 0..2^^N) {
        AS[i] = readln.chomp.to!int;
    }

    while (AS.length > 1) {
        int[] NAS;
        for (int i; i < AS.length; i += 2) {
            if (AS[i] == AS[i+1]) {
                NAS ~= AS[i];
            } else {
                NAS ~= abs(AS[i] - AS[i+1]);
            }
        }
        AS = NAS;
    }
    writeln(AS[0]);
}