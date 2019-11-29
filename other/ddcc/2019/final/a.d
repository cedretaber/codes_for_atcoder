import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);

    auto CS = new int[](N);
    foreach (i; 0..N) {
        CS[i] = S[i] == '>' ? (i ? CS[i-1] : 0) + 1 : 0;
    }
    foreach_reverse (i; 0..N) if (CS[i] != 0 && i+1 < N && CS[i+1]) {
        CS[i] = CS[i+1];
    }
    int x = -1, max_c = -1;
    foreach (i; 0..N) if (S[i] == '-') {
        int c;
        if (i) c += CS[i-1];
        if (i+1 < N) c += CS[i+1];
        if (c > max_c) {
            max_c = c;
            x = i;
        }
    }
    if (x != -1) {
        S[x] = '>';
    }

    double s = 0;
    int k;
    foreach (c; S) {
        if (c == '>') {
            s += 1.0 / (k+2);
            ++k;
        } else {
            s += 1;
            k = 0;
        }
    }
    writefln("%.010f", s);
}