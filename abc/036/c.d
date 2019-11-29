import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] CS, DS;
    CS.length = N;
    DS.length = N;
    foreach (i; 0..N) {
        CS[i] = readln.chomp.to!int;
        DS[i] = CS[i];
    }
    sort(CS);
    CS = CS.uniq.array;
    int[int] TO;
    foreach (int i, c; CS) TO[c] = i;
    foreach (d; DS) writeln(TO[d]);
}