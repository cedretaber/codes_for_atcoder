import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ad = readln.chomp;
    int A = ad[0] - '0';
    int B = ad[1] - '0';
    int C = ad[2] - '0';
    int D = ad[3] - '0';
    
    foreach (o; 0..8) {
        int s = A;
        string o1, o2, o3;
        if (o & 1) {
            s += B;
            o1 = "+";
        } else {
            s -= B;
            o1 = "-";
        }
        if (o & 2) {
            s += C;
            o2 = "+";
        } else {
            s -= C;
            o2 = "-";
        }
        if (o & 4) {
            s += D;
            o3 = "+";
        } else {
            s -= D;
            o3 = "-";
        }
        if (s == 7) {
            writefln("%d%s%d%s%d%s%d=7", A, o1, B, o2, C, o3, D);
            return;
        }
    }
}