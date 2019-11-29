import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nl = readln.split.to!(int[]);
    auto N = nl[0];
    auto L = nl[1];
    
    int s, e = int.max;
    foreach (i; 0..N) {
        s += L+i;
        if (abs(L+i) < abs(e)) e = L+i;
    }
    writeln(s - e);
}