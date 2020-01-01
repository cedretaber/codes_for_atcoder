import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int[] lr;
    int L1, R1, L2, R2, L3, R3;
    lr = readln.split.to!(int[]);
    L1 = lr[0];
    R1 = lr[1];
    lr = readln.split.to!(int[]);
    L2 = lr[0];
    R2 = lr[1];
    lr = readln.split.to!(int[]);
    L3 = lr[0];
    R3 = lr[1];

    double res = 0, lr2 = (R2-L2+1).to!double, lr3 = (R3-L3+1).to!double;
    foreach (p; L1..R1+1) {
        auto p2 = p < L2 ? 1.0 : p >= R2 ? 0.0 : (R2-p).to!double / lr2;
        auto p3 = p < L3 ? 1.0 : p >= R3 ? 0.0 : (R3-p).to!double / lr3;
        res += p2 * p3;
    }
    writefln("%.010f", res / (R1-L1+1).to!double);
}