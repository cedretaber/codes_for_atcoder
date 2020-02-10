import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);
    auto CS = new int[](N*M+1);
    foreach (a; AS) {
        if (CS[a] == 1) {
            writeln(0);
            return;
        }
        CS[a] = 1;
    }
    foreach (b; BS) {
        if (CS[b] >= 2) {
            writeln(0);
            return;
        }
        CS[b] += 2;
    }
    auto DS = new long[](N*M+1);
    auto ES = new long[](N*M+1);
    foreach_reverse (i; 1..N*M+1) {
        DS[i-1] += DS[i] + (CS[i]&1 ? 1 : 0);
        ES[i-1] += ES[i] + (CS[i]&2 ? 1 : 0);
    }

    long r = 1;
    foreach_reverse (x; 1..N*M+1) {
        switch (CS[x]) {
            case 2:
                r = r * DS[x] % P;
                break;
            case 1:
                r = r * ES[x] % P;
                break;
            case 0:
                r = r * (DS[x] * ES[x] - (N*M-x)) % P;
                break;
            default:
        }
    }
    writeln(max(0, r));
}