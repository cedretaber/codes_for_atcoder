import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[100] CS, CCS;

void main()
{
    auto N = readln.chomp.to!int;
    double n_ban = 1;
    foreach (i; 1..N+1) n_ban *= i;
    foreach (i; 0..N) CS[i] = readln.chomp.to!int;
    foreach (i; 0..N) foreach (j; 0..N) if (CS[i] % CS[j] == 0) {
        ++CCS[i];
    }
    double r = 0;
    foreach (i; 0..N) {
        if (CCS[i] == 1) {
            r += 1;
        } else if (CCS[i] % 2 == 0) {
            r += 0.5;
        } else {
            r += (CCS[i] + 1) / (2.0*CCS[i]);
        }
    }
    writefln("%.010f", r);
}