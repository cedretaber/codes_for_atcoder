import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    if (N%2 == 0) {
        writeln("No");
        return;
    }
    writeln("Yes");
    auto nn = new int[][](N, N);
    foreach (i; 0..N) nn[0][i] = N*(i+1);
    foreach (i; 1..N) {
        foreach (j; 0..N-1) nn[i][j] = N*(i-1)+j+1;
        nn[i][N-1] = N*(N-1)+i;
    }

    foreach (n; nn) writeln(n.to!(string[]).join(" "));
}
