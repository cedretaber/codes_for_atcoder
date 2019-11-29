import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    int[] DS1, DS2;
    DS1.length = N + 1;
    DS2.length = N;

    int sum_n;
    foreach (i; 0..N) {
        if (i == 0) {
            DS1[i] = abs(AS[i]);
            DS2[i] = abs(AS[i+1]);
        } else {
            DS1[i] = abs(AS[i-1] - AS[i]);
            DS2[i] = i == N-1 ? abs(AS[i-1]) : abs(AS[i-1] - AS[i+1]);
        }
        sum_n += DS1[i];
    }
    DS1[N] = abs(AS[N-1]);
    sum_n += DS1[N];

    foreach (i; 0..N) {
        if (i != 0) {
            sum_n -= DS2[i-1];
            sum_n += DS1[i-1] + DS1[i];
        }
        sum_n += DS2[i];
        sum_n -= (DS1[i] + DS1[i+1]);
        writeln(sum_n);
    }
}