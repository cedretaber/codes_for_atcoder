import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[200001] OPS;
char[200001] BS;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    foreach (i; 0..Q) {
        auto lr = readln.split.to!(int[]);
        ++OPS[lr[0]-1];
        --OPS[lr[1]];
    }
    int s;
    foreach (i; 0..N) {
        s += OPS[i];
        BS[i] = s%2==0 ? '0' : '1';
    }
    writeln(BS[0..N]);
}