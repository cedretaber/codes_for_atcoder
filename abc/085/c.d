import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    int N, Y;
    readf("%d %d", &N, &Y);
    Y /= 1000;

    foreach (i; 0..N+1) {
        foreach (j; 0..N-i+1) {
            if (Y == i*10 + j*5 + (N-i-j)) {
                writefln("%d %d %d", i, j, (N-i-j));
                return;
            }
        }
    }
    writeln("-1 -1 -1");
}