import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int N;
uint[100] FS;
int[11][100] PS;

int bit_count(uint i) {
    i = i - ((i >>> 1) & 0x55555555);
    i = (i & 0x33333333) + ((i >>> 2) & 0x33333333);
    i = (i + (i >>> 4)) & 0x0f0f0f0f;
    i = i + (i >>> 8);
    i = i + (i >>> 16);
    return i & 0x3f;
}

void main()
{
    N = readln.chomp.to!int;

    foreach (i; 0..N) {
        auto f = readln.split.to!(int[]);
        foreach (j, b; f) if (b) FS[i] |= (1<<j);
    }
    foreach (i; 0..N) PS[i][] = readln.split.to!(int[])[];

    int solve(int i, uint key) {
        if (i == 10) {
            if (!key) return int.min;
            int sum_c;
            foreach (j; 0..N) sum_c += PS[j][bit_count(FS[j] & key)];
            return sum_c;
        } else {
            return max(solve(i+1, key), solve(i+1, key | (1<<i)));
        }
    }

    writeln(solve(0, 0));
}